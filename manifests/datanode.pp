class hadoop::datanode ($enabled = true) {
	include hadoop

        file { "hadoop_datanode_service":
                path    => "/etc/init.d/hadoop-datanode",
                owner   => "root",
                group   => "root",
                content => template("hadoop/service/hadoop-datanode.erb"),
                ensure  => present,
                mode    => 750,
        }

        service { "hadoop-datanode":
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
			    File["hadoop_datanode_service"]],
        }

}
