class gerrit::db {
  include gerrit::params

  notify{$gerrit::params::database_type: }
  notify{$::fqdn: }


  case $gerrit::params::database_type {
    # Installs H2 DB
    'h2': {
      # Do nothing
    }
    # Installs Postgres DB
    'postgresql': {
      class { 'postgresql::server': }

      postgresql::server::db { $gerrit::params::db_name :
        user     => $gerrit::params::db_user,
        password => postgresql_password($gerrit::params::db_user, $gerrit::params::db_pass),
        before   => Class['gerrit::build'],
      }
    }
    default: { fail('Must define $database_type for class gerrit.') }
  }
}
