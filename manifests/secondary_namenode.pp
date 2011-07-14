# Class: hadoop::secondary_namenode
#
# This module configures a node as a hadoop secondary namenode
#
# Parameters:
#
#  $enabled = true
#
# Actions:
#
#  Calls the hadoop class and configures the secondary namenode service
#
# Requires:
#
# Sample Usage:
#  To enable the secondary namenode:
#
#  class { "hadoop::secondary_namenode": enabled => true }
#  
#  or
#
#  include hadoop::secondary namenode
#
#  To disable the secondary namenode:
#
#  class { "hadoop::secondary_namenode": enabled => false } 
#
# [Remember: No empty lines between comments and class definition]
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
