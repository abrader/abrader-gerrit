class gerrit::staging {
  include gerrit

  # Creates staging directory for Gerrit build
  file { $gerrit::stage_dir :
    ensure => directory,
    owner  => $gerrit::user,
    group  => $gerrit::group,
  }

  # Snatches staging file and places in in the staging directory
  staging::file { "${gerrit::stage_dir}/${gerrit::war_file}" :
    source  => $gerrit::war_file_url,
    before  => File["${gerrit::stage_dir}/${gerrit::war_file}"],
    require => File[$gerrit::stage_dir],
  }

  # Insures staging file has correct permissions
  file { "${gerrit::stage_dir}/${gerrit::war_file}" :
    owner  => $gerrit::user,
    group  => $gerrit::group,
    before => Class['gerrit::db'],
  }
}
