class gerrit::service {

  # Copy the init script from Gerrit's default location
  file { '/etc/init.d/gerrit':
    owner  => root,
    group  => root,
    mode   => '0750',
    source => "${gerrit::home}/bin/gerrit.sh",
    require => Exec['build_gerrit'],
  }
  # Manages the Gerrit service
  service { 'gerrit':
    ensure => running,
    enable => true,
    require => [File['/etc/init.d/gerrit'],Exec['build_gerrit']],
  }
}
