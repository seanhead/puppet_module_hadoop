# Class: hadoop::install
#
# This module installs the package and users required for hadoop
#
# Parameters:
#
# Actions:
#
#  Installs hadoop package, creates current symlink, hadoop user, and sets permissions
#
# Requires:
#
# Sample Usage:
#
#  include hadoop::install
#
# [Remember: No empty lines between comments and class definition]
class hadoop::install {
	if !defined (Package["jdk"]) {
		package {"jdk":
				ensure => $hadoop::vars::java_rpm_version,
				provider => "yum",
		}
	}
        
	file {"hadoop_dir":
		path => "/opt/hadoop",
		ensure => directory,
	}
	
	if !$hadoop::vars::source {
		package {"hadoop":
                	ensure   => $hadoop::vars::rpm_version,
                	provider => "yum",
                	require  => Package["jdk"],
        	}
	} else {
		exec {"get_source":
			path    => "/usr/bin",
			command => "wget -P ${hadoop::vars::basedir} ${hadoop::vars::source_location}",
			require => File["hadoop_dir"],
			notify => Exec["extract_source"],
			#onlyif => "test -e ${hadoop::vars::basedir}/${hadoop::vars::source_name}"
			creates => "${hadoop::vars::basedir}/${hadoop::vars::source_name}"
		}

		exec {"extract_source":
			path    => "/bin",
			command => "tar xf ${hadoop::vars::basedir}/${hadoop::vars::source_name} -C ${hadoop::vars::basedir}",
			require => File["hadoop_dir"],
			refreshonly => true,
		}
	}	

        file {'hadoop_symlink':
                ensure  => link,
                path    => '/opt/hadoop/hadoop-current',
                target  => $hadoop::vars::home,
		require => File["hadoop_dir"],
        }

	if !defined(User[$hadoop::vars::user]) {
		user { $hadoop::vars::user:
	                ensure => present,
	                home => '/home/hadoop',
                	managehome => true,
        	        uid => 5000
	        }
	}
}
