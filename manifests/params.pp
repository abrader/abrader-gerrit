class gerrit::params {
  # Gerrit version
  $gerrit_version = $::operatingsystem ? {
    default => '2.8',
  }
  # Gerrit group 
  $group = $::operatingsystem ? {
    default => 'gerrit',
  }
  # Gerrit username 
  $user = $::operatingsystem ? {
    default => 'gerrit',
  }
  # Gerrit Groups 
  $groups = $::operatingsystem ? {
    default => undef,
  }
  # Gerrit deployment directory 
  $home = $::operatingsystem ? {
    default => '/opt/gerrit',
  }
  # Gerrit review_site home 
  $site_name = $::operatingsystem ? {
    default => 'review_site',
  }
  # type of Database storing configs of gerrit ['mysql' / 'pgsql' / 'h2']
  $database_type = $::operatingsystem ? {
    default => 'pgsql',
  }
  
  $war_file = $::operatingsystem ? {
	  default => 'gerrit-2.8.war'
  }
  
  $war_file_url = $::operatingsystem ? {
	  # default => 'http://gerrit-releases.storage.googleapis.com/gerrit-2.8.war',
	  default => "http://gerrit-releases.storage.googleapis.com/${gerrit::params::war_file}",
  }
  
  $stage_dir = $::operatingsystem ? {
	  default => '/opt/staging/gerrit',
  }
  
  $build_script = $::operatingsystem ? {
  	default => "/usr/bin/sudo -u ${gerrit::params::user} /usr/bin/java -jar ${gerrit::params::stage_dir}/${gerrit::params::war_file} init -d ${gerrit::params::home} --batch --no-auto-start"
  }
  
  $init_script = $::operatingsystem ? {
  	default => "/usr/bin/sudo ${gerrit::params::home}/bin/gerrit.sh",
  }
}
