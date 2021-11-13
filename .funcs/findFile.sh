# Macro to find a file
function findfile() {
	if [ $# == 0 ]; then
	 	printf "gimme file names"
	  return
	fi

	trashfile=/tmp/`randomstring`
	edit=0
	for i in "$@"; do
	 	if [[ "$i" != "-v" ]]; then
			find . -iname *"$i"* >> $trashfile
		else 
			edit=1
		fi
	done

	 if [ $edit -eq 1 ] ; then
	 	vim -p `cat $trashfile`
	 else
	  	cat $trashfile
	 fi
	rm $trashfile
}
