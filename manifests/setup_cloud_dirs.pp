# Definition: hadoop::setup_cloud_dirs
#
#  This is the hadoop::setup_cloud_dirs function in the hadoop module.
#
# Parameters:
#  
#  While not explicitly taking a parameter, it uses each element in an array as $name
#
# Actions:
#  
#  Creates the required local directories for the namenode, secondary namenode, and a datanode.
#
# Requires:
#
# Sample Usage:
#
#  hadoop::setup_cloud_dirs { $directories: }
# [NOTE: $directories should be an array if multiple directories need to be created]
#
# [Remember: No empty lines between comments and class definition]
define hadoop::setup_cloud_dirs {
	# File defaults
	File { ensure  => directory }

	# Setup single directory structure
	if !defined(File[$name]){
		file { $name: }
	}

	file { 
		"${name}/hadoop":; 
		"${name}/hadoop/hdfs":; 
		"${name}/hadoop/hdfs/name":; 
		"${name}/hadoop/hdfs/data":; 
		"${name}/hadoop/mapred":; 
		"${name}/hadoop/mapred/local":;
		"${name}/hadoop/hdfs/secondaryname":; 
	}

	# Set permissions
	exec { "chown ${name}/hadoop":
		path    => "/bin",
		command => "chown -R ${hadoop::vars::user}:${hadoop::vars::group} ${name}/hadoop",
		require => [Class["hadoop::install"],
			     File["${name}/hadoop/hdfs/name"],
			     File["${name}/hadoop/hdfs/data"],
			     File["${name}/hadoop/hdfs/secondaryname"],
			     File["${name}/hadoop/mapred/local"]]
	}
}
