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
  $version       = $gerrit::params::gerrit_version,
  $group                = $gerrit::params::gerrit_group,
  $user          	= $gerrit::params::gerrit_user,
  $groups        = $gerrit::params::gerrit_groups,
  $home                 = $gerrit::params::gerrit_home,
  $site_name     = $gerrit::params::gerrit_site_name,
  $canonical_web_url    = $gerrit::params::canonical_web_url,
  $sshd_listen_address  = $gerrit::params::sshd_listen_address,
  $httpd_listen_url     = $gerrit::params::httpd_listen_url,
  $stage_dir            = $gerrit::params::stage_dir,
  $database_type        = $gerrit::params::database_type,
  $war_file             = $gerrit::params::war_file,
) inherits gerrit::params {

  include apache
  include java
  
  # TODO: Need to make this work with Tomcat
  #include tomcat
   
  package { 'wget':
    ensure => present,
  }
  
  # Package necessary for Gerrit operation
  package { 'git':
    ensure => present,
  }
  
  # Creates user necessary for Gerrit operation
  user { $gerrit::params::user :
    ensure     => present,
    home       => $gerrit::params::home, 
    managehome => true,
    before     => File[$gerrit::params::home],
  }
  
  # Creates Gerrit user home directory
  file { $gerrit::params::home :
    owner  => $gerrit::params::user,
    group  => $gerrit::params::group,
    ensure => directory,
    before => File[$gerrit::params::stage_dir],
  }

  include gerrit::staging
  include gerrit::db
  include gerrit::build
  include gerrit::start
  
}
