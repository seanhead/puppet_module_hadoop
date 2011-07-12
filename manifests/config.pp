class hadoop::config {
	$java_home="/usr/java/latest"

	File { require => Class["hadoop::install"] }
	
	# File defaults
	File {
		owner => $hadoop::vars::user,
		group => $hadoop::vars::group,
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
