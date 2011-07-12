class hadoop::namenode ($enabled = true) {
	include hadoop

	file { "hadoop_namenode_service":
                path    => "/etc/init.d/hadoop-namenode",
                owner   => "root",
                group   => "root",
                content => template("hadoop/service/hadoop-namenode.erb"),
                ensure  => present,
                mode    => 750,
        }

        service { "hadoop-namenode":
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
                           # Class["hadoop::clouddirs"],
			     File["hadoop_namenode_service"]],
        }

}
