class hadoop::jobtracker ($enabled = true) {
        include hadoop

	file { "hadoop_jobtracker_service":
                path    => "/etc/init.d/hadoop-jobtracker",
                owner   => "root",
                group   => "root",
                content => template("hadoop/service/hadoop-jobtracker.erb"),
                ensure  => present,
                mode    => 750,
        }

        service { "hadoop-jobtracker":
                enable => $enabled ? {
                        true     => true,
                        false    => false,
                        default  => false,
                },
                ensure => $enabled ? {
                        true     => 'running',
                        false    => 'stopped',
                        default  => 'stopped',
                },
		require => [Class["hadoop::install"],
                            Class["hadoop::config"],
                            #Class["hadoop::clouddirs"],
			     File["hadoop_jobtracker_service"]],
        }

}
