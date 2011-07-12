class hadoop::secondary_namenode ($enabled = true) {
	include hadoop
	
	file { "hadoop_secondary_namenode_service":
               path     => "/etc/init.d/hadoop-secondarynamenode",
                owner   => "root",
                group   => "root",
                content => template("hadoop/service/hadoop-secondarynamenode.erb"),
                ensure  => present,
                mode    => 750,
        }

        service { "hadoop-secondarynamenode":
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
                         #   Class["hadoop::clouddirs"],
			     File["hadoop_secondary_namenode_service"]],
        }
}
