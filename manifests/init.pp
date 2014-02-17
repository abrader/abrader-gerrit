# Class: gerrit
#
# This module manages gerrit
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class gerrit (
  $gerrit_version       = gerrit::params::gerrit_version,
  $group         		= gerrit::params::gerrit_group,
  $user          		= gerrit::params::gerrit_user,
  $gerrit_groups        = gerrit::params::gerrit_groups,
  $home                 = gerrit::params::gerrit_home,
  $gerrit_site_name     = gerrit::params::gerrit_site_name,
  $gerrit_database_type = gerrit::params::gerrit_database_type,
  $canonical_web_url    = gerrit::params::canonical_web_url,
  $sshd_listen_address  = gerrit::params::sshd_listen_address,
  $httpd_listen_url     = gerrit::params::httpd_listen_url,
  $download_mirror      = 'http://gerrit.googlecode.com/files',
  $stage_dir            = gerrit::params::stage_dir,
  $war_file_url			= 'http://gerrit-releases.storage.googleapis.com/',
  $war_file             = 'gerrit-2.8.1.war',
)
  inherits gerrit::params 
  {
	  include apache
	  include java
	  include tomcat
	  
	  package { 'wget':
		  ensure => present,
	  }
	  
	  package { 'git':
		  ensure => present,
	  }
	  
	  user { $gerrit::params::user :
	    ensure     => present,
	    home       => $gerrit::params::home, 
	    managehome => true,
		before => File[$gerrit::params::home],
	  }
	  
	  file { $gerrit::params::home :
  		owner => $gerrit::params::user,
  		group => $gerrit::params::group,
  		ensure => directory,
		before => File[$gerrit::params::stage_dir],
	  }
	  
	  # class { 'postgresql::server': }
	  # 
	  # postgresql::server::db { 'reviewdb':
	  #   user     => 'gerrit2',
	  #   password => postgresql_password('postgres', 'gerrit2'),
	  # }
	  
	  include gerrit::staging
	  include gerrit::build
	  include gerrit::install
  	  include gerrit::start

}
