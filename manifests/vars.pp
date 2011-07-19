# Class: hadoop::vars
#
# This module hold all the variables in the hadoop module
#
# Parameters:
#
#  $reducetasks=2
#  $maptasks=2,
#  $clouddirs=''
#  $source=false
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
#		clouddirs => ["/disk0","/disk1"],
#   }
#
# [Remember: No empty lines between comments and class definition]
class hadoop::vars ( 
	$reducetasks=2,
	$maptasks=2,
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
	$basedir = "/opt/hadoop"

	$user="hadoop"
	$group="hadoop"
	$dfs_replication=3
	$namenode_port=9000
	$jobtracker_port=9001

	# Java variables
	$java_home="/usr/java/latest"
	$java_rpm_version="1.6.0_25-fcs"

	# Class variables
	# These are set by overriding the default values
	$map_tasks=$maptasks
	$reduce_tasks=$reducetasks
	
	# Use cloud_dirs fact unless directories are passed into class
	if !$clouddirs {
		$dirs = split($cloud_dirs, ',')
	} else {
		$dirs = $clouddirs
	}
	
	# If source is true, you need to define the following vars:
	if $source {
		# Name of the hadoop source package
		$source_name = "hadoop-0.20.203.0rc1.tar.gz"
		# Where to get the hadoop source package
		$source_location = "http://puppet/${source_name}"
		# NOTE: $basedir is the directory where hadoop will be extracted to
	}
}
