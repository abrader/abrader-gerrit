class gerrit::db {

  notify{ $gerrit::database_type: }


  case $gerrit::database_type {
    # Installs H2 DB
    'h2': {
      # Do nothing
    }
    # Installs Postgres DB
    'postgresql': {
      class { 'postgresql::server': }

      postgresql::server::db { $gerrit::db_name :
        user     => $gerrit::db_user,
        password => postgresql_password($gerrit::db_user, $gerrit::db_pass),
        before   => Class['gerrit::build'],
      }
    }
    default: { fail('Must define $database_type for class gerrit.') }
  }
}
