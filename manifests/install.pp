class hadoop::install {
	include jdk
	include hadoop::vars

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
