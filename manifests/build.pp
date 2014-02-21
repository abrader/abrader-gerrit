class gerrit::build {
	include gerrit::params
  
  file { "${gerrit::params::home}/etc" :
    ensure => directory,
    owner  => $gerrit::params::user,
    group  => $gerrit::params::group,
  }
  
  file { "${gerrit::params::home}/etc/secure.config" :
    ensure => file,
    owner  => $gerrit::params::user,
    group  => $gerrit::params::group,
    mode   => '0600',
    source => 'puppet:///modules/gerrit/secure.config',
    replace => false,
    require => File["${gerrit::params::home}/etc"],
    before => Exec['build_gerrit'],
    notify  => Exec['build_gerrit'],
  }
  
  file { 'gerrit_config' :
    path => "${gerrit::params::home}/etc/gerrit.config",
    owner  => $gerrit::params::user,
    group  => $gerrit::params::group,
    mode   => '0664',
    content => template('gerrit/gerrit.config.erb'),
    replace => false,
    require => File["${gerrit::params::home}/etc"],
    before => Exec["build_gerrit"],
    notify  => Exec['build_gerrit'], 
  }
  
  exec { "build_gerrit" :
    cwd       => $gerrit::params::home,
    creates   => "${gerrit::params::home}/bin/gerrit.sh",
    notify    => Exec['start_gerrit'],
    tries     => '2',
    command   => $database_type ? {
      'postgresql' => "/usr/bin/sudo -u ${gerrit::params::user} /usr/bin/java -jar ${gerrit::params::stage_dir}/${gerrit::params::war_file} init --batch -d ${gerrit::params::home} --no-auto-start",
      default      => "/usr/bin/sudo -u ${gerrit::params::user} /usr/bin/java -jar ${gerrit::params::stage_dir}/${gerrit::params::war_file} init -d ${gerrit::params::home} --batch --no-auto-start",
    }
  }
}