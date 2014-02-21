class gerrit::params {
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
  
  $db_user = $::operatingsystem ? {
    default => 'gerrit2'
  }
  
  $db_pass = $::operatingsystem ? {
    default => 'gerrit2'
  }
  
  $db_name = $::operatingsystem ? {
    default => 'reviewdb'
  }
  
  $database_type = $::operatingsystem ? {
    default => 'postgresql'
    #default => 'h2'
  }
  
  $war_file = $::operatingsystem ? {
    default => 'gerrit-2.8.1.war'
  }
  
  $war_file_url = $::operatingsystem ? {
    default => "http://gerrit-releases.storage.googleapis.com/${gerrit::params::war_file}",
  }
  
  $stage_dir = $::operatingsystem ? {
    default => "${gerrit::params::home}/staging",
  }
  
  # $build_script = $database_type ? {
  #   postgresql => "/usr/bin/sudo -u ${gerrit::params::user} /usr/bin/java -jar ${gerrit::params::stage_dir}/${gerrit::params::war_file} init -d ${gerrit::params::home}",
  #   
  #   default => "/usr/bin/sudo -u ${gerrit::params::user} /usr/bin/java -jar ${gerrit::params::stage_dir}/${gerrit::params::war_file} init -d ${gerrit::params::home} --batch --no-auto-start",
  # }
  
  $init_script = $::operatingsystem ? {
    default => "/usr/bin/sudo ${gerrit::params::home}/bin/gerrit.sh",
  }
}
