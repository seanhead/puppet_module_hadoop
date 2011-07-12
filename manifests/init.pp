class hadoop {
	require hadoop::vars
	include hadoop::install, hadoop::config
}
