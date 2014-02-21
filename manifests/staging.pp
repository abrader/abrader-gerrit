class gerrit::staging {
  include gerrit::params

  # Creates staging directory for Gerrit build
  file { $gerrit::params::stage_dir :
    ensure => directory,
    owner  => $gerrit::params::user,
    group  => $gerrit::params::group,
  }
  
  # Snatches staging file and places in in the staging directory
  staging::file { "${gerrit::params::stage_dir}/${gerrit::params::war_file}" :
    source => $gerrit::params::war_file_url,
    before => File["${gerrit::params::stage_dir}/${gerrit::params::war_file}"],
    require => File[$gerrit::params::stage_dir],
  }
	
  # Insures staging file has correct permissions
  file { "${gerrit::params::stage_dir}/${gerrit::params::war_file}" :
    owner  => $gerrit::params::user,
    group  => $gerrit::params::group,
    before => Class['gerrit::db'],
  }
  
}
