# Class: hadoop::jobtracker
#
# This module configures a node as a hadoop jobtracker
#
# Parameters:
#
#  $enabled = true
#
# Actions:
#
#  Calls the hadoop class and configures the jobtracker service
#
# Requires:
#
# Sample Usage:
#  To enable the jobtracker:
#
#  class { "hadoop::jobtracker": enabled => true }
#  
#  or
#
#  include hadoop::jobtracker
#
#  To disable the jobtracker:
#
#  class { "hadoop::jobtracker": enabled => false } 
#
# [Remember: No empty lines between comments and class definition]
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
		hasrestart => true,
		require    => [Class["hadoop::install"],
                               Class["hadoop::config"],
			        File["hadoop_jobtracker_service"]],
        }

}
