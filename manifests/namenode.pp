# Class: hadoop::namenode
#
# This module configures a node as a hadoop namenode
#
# Parameters:
#
#  $enabled = true
#
# Actions:
#
#  Calls the hadoop class and configures the namenode service
#
# Requires:
#
# Sample Usage:
#  To enable the namenode:
#
#  class { "hadoop::namenode": enabled => true }
#  
#  or
#
#  include hadoop::namenode
#
#  To disable the namenode:
#
#  class { "hadoop::namenode": enabled => false } 
#
# [Remember: No empty lines between comments and class definition]
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
		hasrestart => true,
		require    => [Class["hadoop::install"],
                               Class["hadoop::config"],
			        File["hadoop_namenode_service"]],
        }

}
