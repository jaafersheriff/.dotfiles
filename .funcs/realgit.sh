
# Get mad if rebasing without -i
# checkout branch shortcut
alias realgit='/c/Program\ Files/Git/bin/git.exe'
function git() {
	if [[ $1 == "rebase" ]] ; then
		for j in "$@"; do
			if [[ $j == "-i" ]] ; then
				realgit fetch
				realgit "$@"
				git sb
				return $?
			fi
		done
		printf "YOU FORGOT TO DO INTERACTIVE MODE!\n"
		printf "If this is desired use realgit\n"
		return 1
	fi

	if [[ "$1" == "cb" ]] ; then
		shift
		realgit stash 
		realgit fetch
		realgit checkout "$1" && realgit pull && git sb
		printf "Don't forget to stash pop"
		return 0
	fi 

	if [[ "$1" == "sb" ]] ; then
		realgit submodule sync && realgit submodule update --init --recursive
		return $?
	fi

	if [[ "$1" == "fulldiff" ]] ; then
		shift
		if [[ $# -eq 0 ]] ; then
				echo "Please supply a merge branch for comparison"
				return 1
		fi

		mergebranch=$1
		shift
		currentbranch=`(realgit branch | grep \* | sed 's/.* //g' | sed 's/(\|)//g')`
		mergecommit=`(realgit merge-base $currentbranch $mergebranch)`
		if [[ "$?" -ne 0 ]]; then
			return 1
 		fi

		list=0
		commit=0
		for i in "$@"; do
			if [[ $i == "-l" ]] ; then
				list=1
				shift
			fi
			if [[ $i == "-c" ]] ; then
				commit=1
				shift
			fi
		done

		if [[ $commit -eq 1 ]] ; then
			echo ""
			echo "Current Branch: " $currentbranch
			realgit show -s --format=%ci $currentbranch
			realgit log --oneline --ancestry-path $mergecommit..$currentbranch "$@"
			echo ""
			echo "Merge Branch: " $mergebranch " @ " $mergecommit
			realgit show -s --format=%ci $mergecommit
			realgit log --oneline $mergecommit -1 "$@"
		fi
		if [[ $list -eq 1 ]] ; then
			trashfile=/tmp/`randomstring`
			realgit diff --stat $mergecommit $currentbranch "$@" > $trashfile
			echo ""
			echo "FILES"
			cat $trashfile
			rm $trashfile
		fi

		if [ \( $commit -eq 0 -a $list -eq 0 \) ] ; then
			realgit diff $mergecommit "$@"
		fi

		return 0
	fi

	if [[ "$1" == "fullstatus" ]]; then
		shift
		realgit status "$@"
		return 0
	fi 

	if [[ ( "$1" == "diff" && "$2" == "-v" ) ]] ; then
		trashfile=/tmp/`randomstring`
		realgit -c color.status=false status -s > $trashfile
		sed -i '/^M */d' $trashfile
		sed -i 's/.* //g' $trashfile
		cat $trashfile
		vim -p `cat $trashfile`
		rm $trashfile
		return 0
	fi

	realgit "$@"
	return $?
}
