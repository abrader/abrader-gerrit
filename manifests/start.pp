class gerrit::start {
  include gerrit::params

    # Starts the Gerrit service
    exec { 'start_gerrit' :
      cwd       => $gerrit::params::home,
      command   => "${gerrit::params::init_script} restart",
      creates   => "${gerrit::params::home}/logs/gerrit.pid",
      require   => Exec['build_gerrit'],
    }
}
