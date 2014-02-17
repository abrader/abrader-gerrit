class gerrit::staging {
	include gerrit::params
	
	file { $gerrit::params::stage_dir :
		owner => $gerrit::params::user,
		group => $gerrit::params::group,
		ensure => directory,
	}
	
	staging::file { "${gerrit::params::stage_dir}/${gerrit::params::war_file}" :
		source => $gerrit::params::war_file_url,
		before => Exec["build_gerrit"],
		require => File[$gerrit::params::stage_dir],
	}
	
}