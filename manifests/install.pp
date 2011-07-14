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
	if !defined Package["jdk"] {
		package {"jdk":
				ensure => $hadoop::vars::java_rpm_version,
				provider => "yum",
		}
	}
        
	package {"hadoop":
                ensure   => $hadoop::vars::rpm_version,
                provider => "yum",
                require  => Package["jdk"],
        }

        file {'hadoop_symlink':
                ensure  => link,
                path    => '/opt/hadoop/hadoop-current',
                target  => $hadoop::vars::home,
		require => Package["hadoop"],
        }

	if !defined(User[$hadoop::vars::user]) {
		user { $hadoop::vars::user:
	                ensure => present,
	                home => '/home/hadoop',
                	managehome => true,
        	        uid => 5000
	        }
	}

	exec {'chown_hadoop_home':
                path    => '/bin',
                command => "chown -R ${hadoop::vars::user}.${hadoop::vars::group} ${hadoop::vars::home}",
                require => [Package["hadoop"],User[$hadoop::vars::user]],
        }
}
