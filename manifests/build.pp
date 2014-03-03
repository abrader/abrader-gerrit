class gerrit::build {
  include gerrit

  # Manage ~/etc
  file { "${gerrit::home}/etc" :
    ensure => directory,
    owner  => $gerrit::user,
    group  => $gerrit::group,
  }

  # Manage ~/etc/secure.config necessary for Gerrit init
  file { "${gerrit::home}/etc/secure.config" :
    ensure  => file,
    owner   => $gerrit::user,
    group   => $gerrit::group,
    mode    => '0600',
    source  => 'puppet:///modules/gerrit/secure.config',
    replace => false,
    require => File["${gerrit::home}/etc"],
    before  => Exec['build_gerrit'],
    notify  => Exec['build_gerrit'],
  }

  # Manage ~/etc/gerrit.config necessary for Gerrit init
  file { 'gerrit_config' :
    path    => "${gerrit::home}/etc/gerrit.config",
    owner   => $gerrit::user,
    group   => $gerrit::group,
    mode    => '0664',
    content => template('gerrit/gerrit.config.erb'),
    replace => false,
    require => File["${gerrit::home}/etc"],
    before  => Exec['build_gerrit'],
    notify  => Exec['build_gerrit'],
  }

  # gerrit initialization command depends on db type
  case $gerrit::database_type {
    'postgresql': {
      $initialization_command = "/usr/bin/sudo -u ${gerrit::user} /usr/bin/java -jar ${gerrit::stage_dir}/${gerrit::war_file} init --batch -d ${gerrit::home} --no-auto-start"
    }
    default: {
      $initialization_command = "/usr/bin/sudo -u ${gerrit::user} /usr/bin/java -jar ${gerrit::stage_dir}/${gerrit::war_file} init -d ${gerrit::home} --batch --no-auto-start"
    }
  }

  # Execution of Gerrit init to build custom war file
  exec { 'build_gerrit':
    cwd       => $gerrit::home,
    creates   => "${gerrit::home}/bin/gerrit.sh",
    notify    => Service['gerrit'],
    tries     => '2',
    command   => $initialization_command,
  }
}
