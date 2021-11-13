

function runcmd() {
	command=$1
	args=""
	shift
	if [[ $# -gt 0 ]]; then
		for j in "$@"; do
			args=" $args $j"
		done
	fi

	echo "Calling $command with $args"
	cmd "/C $command$args"
}
