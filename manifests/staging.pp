class gerrit::staging {
	include gerrit::params
	
	staging::file { $gerrit::params::war_file :
		source => $gerrit::params::war_file_url,
    }
	
	# staging::file { $gerrit::params::war_file :
	# 	target => $gerrit::params::stage_dir,
	# 	creates => "${gerrit::params::stage_dir}/${gerrit::params::war_file}",
	# 	requires => File[$gerrit::params::stage_dir],
	# }
}