# Class: hadoop
#
# This module manages hadoop hdfs and hadoop mapreduce.
#
# Parameters:
#
# Actions:
#
#  Calls the hadoop::vars, hadoop::install, and hadoop::config classes.
#
# Requires:
#
# Sample Usage:
#
#  include hadoop
#
# [Remember: No empty lines between comments and class definition]
class hadoop {
	require hadoop::vars
	include hadoop::install, hadoop::config
}