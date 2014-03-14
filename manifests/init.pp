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
  $group                = $gerrit::params::group,
  $user                 = $gerrit::params::user,
  $groups               = $gerrit::params::groups,
  $home                 = $gerrit::params::home,
  $stage_dir            = $gerrit::params::stage_dir,
  $database_type        = $gerrit::params::database_type,
  $war_file             = $gerrit::params::war_file,
  $manage_java          = $gerrit::params::manage_java,
) inherits gerrit::params {

  # Manage user necessary for Gerrit operation
  user { $user :
    ensure     => present,
    home       => $home,
    managehome => true,
    before     => File[$home],
  }

  # Manage Gerrit user home directory
  file { $home :
    owner  => $user,
    group  => $group,
    ensure => directory,
    before => File[$stage_dir],
  }
  file { 'gerrit_defaults':
    ensure  => file,
    path    => '/etc/default/gerritcodereview',
    owner   => root,
    group   => root,
    mode    => '0750',
    content => template('gerrit/gerritcodereview.erb'),
  }
  if $manage_java == true {
    class { '::java': }
  }
  include ::gerrit::staging
  include ::gerrit::db
  include ::gerrit::build
  include ::gerrit::service
}
