# Class: hadoop::config
#
# This module manages the configuration of hadoop.
#
# Parameters:
#
# Actions:
#  Populates the following config files in hadoops conf directory:
#   - hadoop-env.sh
#   - core-site.xml
#   - hdfs-site.xml
#   - excludes (just creates the file for now...)
#   - calls the hadoop::setup_cloud_dirs function
#
# Requires:
#
# Sample Usage:
#
#  include hadoop::config
#
# [Remember: No empty lines between comments and class definition]
class hadoop::config {	
	
	# File defaults
	File {
		owner => $hadoop::vars::user,
		group => $hadoop::vars::group,
		require => Class["hadoop::install"],
	}

	# Hadoop configs
	file {  "hadoop_env":
	                path    => "${hadoop::vars::home}/conf/hadoop-env.sh",
	                content => template("hadoop/conf/hadoop-env.sh.erb");
		"core_site":
	                path    => "${hadoop::vars::home}/conf/core-site.xml",
	                content => template("hadoop/conf/core-site.xml.erb");
		"hdfs_site":
                	path    => "${hadoop::vars::home}/conf/hdfs-site.xml",
	                content => template("hadoop/conf/hdfs-site.xml.erb");
	        "mapred-site":
                	path    => "${hadoop::vars::home}/conf/mapred-site.xml",
	                content => template("hadoop/conf/mapred-site.xml.erb");
	        "excludes":
	                path    => "${hadoop::vars::home}/conf/excludes",
	                ensure  => present;
	}
	
	# Create the directories
	hadoop::setup_cloud_dirs { $hadoop::vars::dirs: }

}
