# List files that contain a certain text
# Optional param for dir
function findtext() {
	if [ $# == 0 ]; then
	 	printf "gimme text"
		return
	fi

	trashfile=/tmp/`randomstring`
	edit=0
	for i in "$@"; do
	 	if [[ "$i" != "-v" ]]; then
			find . -type f -exec grep -il "$i" {} \; >> $trashfile
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
