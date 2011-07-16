# Class: hadoop::vars
#
# This module hold all the variables in the hadoop module
#
# Parameters:
#
#  $reducetasks=2
#  $maptasks=2,
#  $dfsreplication=3,
#  $namenodeport=9000,
#  $jobtrackerport=9001,
#  $clouddirs=''
#  [NOTE: Override this to manually specify local directories]
#
# Actions:
#
#  Defines variables for the hadoop module
#
# Requires:
#
# Sample Usage:
#
#  class { "hadoop::vars":
#  		maptasks => 3,
#		reducetasks => 4,
#		clouddirs => ["/disk0","/disk1"]
#   }
#
# [Remember: No empty lines between comments and class definition]
class hadoop::vars ( 
	$reducetasks=2,
	$maptasks=2,
	$dfsreplication=3,
	$namenodeport=9000,
	$jobtrackerport=9001,
	$clouddirs='',
	$source=false
) {
	# Change these to your namenode/jobtracker hostnames
	$namenode="puppet"
	$jobtracker="puppet"

	# Hadoop variables
	#$version="0.20.2"
	$version="0.20.203.0"
	$rpm_version="0.20.2-1"
	$home="/opt/hadoop/hadoop-${version}"
	$user="hadoop"
	$group="hadoop"
	
	# Java variables
	$java_home="/usr/java/latest"
	$java_rpm_version="1.6.0_25-fcs"

	# Class variables
	# These are set by overriding the default values
	$map_tasks=$maptasks
	$reduce_tasks=$reducetasks
	$dfs_replication=$dfsreplication
	$namenode_port=$namenodeport
	$jobtracker_port=$jobtrackerport

	# Use cloud_dirs fact unless directories are passed in
	if !$clouddirs {
		$dirs = split($cloud_dirs, ',')
	} else {
		$dirs = $clouddirs
	}

	if $source {
		$source_name = "hadoop-0.20.203.0rc1.tar.gz"
		$source_location = "http://puppet/${source_name}"
		$basedir = "/opt/hadoop"
	}
}
