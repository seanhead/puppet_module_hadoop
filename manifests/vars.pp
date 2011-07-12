class hadoop::vars ( 
	$reducetasks=2,
	$maptasks=2,
	$dfsreplication=3,
	$namenodeport=9000,
	$jobtrackerport=9001,
	$clouddirs=''
) {
	$version="0.20.2"
	$rpm_version="0.20.2-1"
	$home="/opt/hadoop/hadoop-${version}"

	$user="hadoop"
	$group="hadoop"

	$namenode="puppet"
	$jobtracker="puppet"

	# Class variables
	$map_tasks=$maptasks
	$reduce_tasks=$reducetasks
	$dfs_replication=$dfsreplication
	$namenode_port=$namenodeport
	$jobtracker_port=$jobtrackerport

	if !$clouddirs {
		$dirs = split($cloud_dirs, ',')
	} else {
		$dirs = $clouddirs
	}
}
