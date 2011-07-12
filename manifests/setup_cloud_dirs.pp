define hadoop::setup_cloud_dirs {
	File { ensure  => directory }
	Exec { path    => "/bin" }

	file { $name: }
	file { "${name}/hadoop": }
	file { "${name}/hadoop/hdfs": }
	file { "${name}/hadoop/hdfs/name": }
	file { "${name}/hadoop/hdfs/data": }
	file { "${name}/hadoop/mapred": }
	file { "${name}/hadoop/mapred/local": }
	file { "${name}/hadoop/hdfs/secondaryname": }

	exec { "chown ${name}/hadoop":
		command => "chown -R ${hadoop::vars::user}:${hadoop::vars::group} ${name}/hadoop",
		require => [Class["hadoop::install"],
			     File["${name}/hadoop/hdfs/name"],
			     File["${name}/hadoop/hdfs/data"],
			     File["${name}/hadoop/hdfs/secondaryname"],
			     File["${name}/hadoop/mapred/local"]]
	}
}
