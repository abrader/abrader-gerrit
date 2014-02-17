class gerrit::build {
	include gerrit::params
	
    exec { "build_gerrit" :
	  cwd       => $gerrit::params::home,
	  command   => $gerrit::params::build_script,
	  creates   => "${gerrit::params::home}/bin/gerrit.sh",
    }
}