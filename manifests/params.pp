class gerrit::params {
  # Gerrit user
  $user = $::operatingsystem ? {
    default => 'gerrit2',
  }
  # Gerrit group 
  $group = $::operatingsystem ? {
    default => 'gerrit2',
  }
  # Gerrit Groups 
  $groups = $::operatingsystem ? {
    default => undef,
  }
  # Gerrit deployment directory 
  $home = $::operatingsystem ? {
    default => '/opt/gerrit',
  }
  # Gerrit Postgres DB user
  $db_user = $::operatingsystem ? {
    default => 'gerrit2'
  }
  # Password for Gerrit Postgres DB user
  $db_pass = $::operatingsystem ? {
    default => 'gerrit2'
  }
  # Gerrit Postgres DB name
  $db_name = $::operatingsystem ? {
    default => 'reviewdb'
  }
  # Database type (i.e., h2, postgresql, mysql)
  $database_type = $::operatingsystem ? {
    default => 'postgresql'
    #default => 'h2'
  }
  # Name of Gerrit war file
  $war_file = $::operatingsystem ? {
    default => 'gerrit-2.8.1.war'
  }
  # URL where the Gerrit war file can be found
  $war_file_url = $::operatingsystem ? {
    default => "http://gerrit-releases.storage.googleapis.com/${gerrit::params::war_file}",
  }
  # Staging directory for where the Gerrit war file should reside
  $stage_dir = $::operatingsystem ? {
    default => "${gerrit::params::home}/staging",
  }
  # Start script
  $init_script = $::operatingsystem ? {
    default => "/usr/bin/sudo -u ${gerrit::params::user} ${gerrit::params::home}/bin/gerrit.sh",
  }
}
