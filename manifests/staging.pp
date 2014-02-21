class gerrit::staging {
  include gerrit::params

  file { $gerrit::params::stage_dir :
    ensure => directory,
    owner  => $gerrit::params::user,
    group  => $gerrit::params::group,
  }

  staging::file { "${gerrit::params::stage_dir}/${gerrit::params::war_file}" :
    source => $gerrit::params::war_file_url,
    before => File["${gerrit::params::stage_dir}/${gerrit::params::war_file}"],
    require => File[$gerrit::params::stage_dir],
  }
	
  file { "${gerrit::params::stage_dir}/${gerrit::params::war_file}" :
    owner  => $gerrit::params::user,
    group  => $gerrit::params::group,
    before => Class['gerrit::db'],
  }
  
}
