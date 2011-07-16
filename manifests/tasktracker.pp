# Class: hadoop::tasktracker
#
# This module configures a node as a hadoop tasktracker
#
# Parameters:
#
#  $enabled = true
#
# Actions:
#
#  Calls the hadoop class and configures the tasktracker service
#
# Requires:
#
# Sample Usage:
#  To enable the tasktracker:
#
#  class { "hadoop::tasktracker": enabled => true }
#  
#  or
#
#  include hadoop::tasktracker
#
#  To disable the tasktracker:
#
#  class { "hadoop::tasktracker": enabled => false } 
#
# [Remember: No empty lines between comments and class definition]
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
		hasrestart => true,
		require    => [Class["hadoop::install"],
                               Class["hadoop::config"],
			        File["hadoop_tasktracker_service"]],
        }
}
