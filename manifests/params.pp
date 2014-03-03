class gerrit::params {
  # Gerrit user
  $user = 'gerrit2'

  # Gerrit group
  $group = 'gerrit2'

  # Additional Gerrit Groups
  $groups = undef

  # Gerrit deployment directory
  $home = '/opt/gerrit'

  # Gerrit Postgres DB user
  $db_user = 'gerrit2'

  # Password for Gerrit Postgres DB user.
  # IT IS HIGHLY RECOMMENDED THAT YOU OVERRIDE THIS VALUE
  $db_pass = 'gerrit2'

  # Gerrit Postgres DB name
  $db_name = 'reviewdb'

  # Database type (i.e., h2, postgresql, mysql)
  $database_type = 'postgresql'

  # Name of Gerrit war file
  $war_file = 'gerrit-2.8.1.war'

  # URL where the Gerrit war file can be found
  $war_file_url = "http://gerrit-releases.storage.googleapis.com/${gerrit::params::war_file}"

  # Staging directory for where the Gerrit war file should reside
  $stage_dir = "${gerrit::home}/staging"

  # Start script
  $init_script = $::operatingsystem ? {
    default => "/usr/bin/sudo -u ${gerrit::params::user} ${gerrit::params::home}/bin/gerrit.sh",
  }
}
