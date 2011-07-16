# Class: hadoop::datanode
#
# This module configures a node as a hadoop datanode
#
# Parameters:
#
#  $enabled = true
#
# Actions:
#
#  Calls the hadoop class and configures the datanode service
#
# Requires:
#
# Sample Usage:
#  To enable the datanode:
#
#  class { "hadoop::datanode": enabled => true }
#  
#  or
#
#  include hadoop::datanode
#
#  To disable the datanode:
#
#  class { "hadoop::datanode": enabled => false } 
#
# [Remember: No empty lines between comments and class definition]
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
		hasrestart => true,
		require    => [Class["hadoop::install"],
			       Class["hadoop::config"],
			        File["hadoop_datanode_service"]],
        }

}
