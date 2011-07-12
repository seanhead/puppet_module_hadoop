class hadoop::tasktracker ($enabled = true) {
	include hadoop
        file { "hadoop_tasktracker_service":
                path    => "/etc/init.d/hadoop-tasktracker",
                owner   => "root",
                group   => "root",
                content => template("hadoop/service/hadoop-tasktracker.erb"),
                ensure  => present,
                mode    => 750,
        }

        service { "hadoop-tasktracker":
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
                       #     Class["hadoop::clouddirs"],
			     File["hadoop_tasktracker_service"]],
        }
}
