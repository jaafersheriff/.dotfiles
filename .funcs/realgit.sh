
alias realgit='/mnt/c/Program\ Files/Git/cmd/git.exe'
function git() {
	cmd=$1
	shift

	if [[ "$cmd" == "rebase" ]] ; then
		for j in "$@"; do
			if [[ $j == "-i" ]] ; then
				realgit fetch
				realgit rebase "$@"
				git sb
				return $?
			fi
		done
		printf "YOU FORGOT TO DO INTERACTIVE MODE!\n"
		printf "If this is desired use realgit\n"
		return 1
	fi

	if [[ "$cmd" == "sb" ]] ; then
		realgit submodule sync && realgit submodule update --init --recursive
		return $?
	fi

	if [[ "$cmd" == "fulldiff" ]] ; then
		if [[ $# -eq 0 ]] ; then
				echo "Please supply a merge branch for comparison"
				return 1
		fi

		mergebranch=$1
		shift

		OPTIND=1
		optList=0
		optCommit=0
		for i in "$@"; do
			if [[ "$i" == "-c" ]]; then
				optCommit=1
				shift
			fi
			if [[ "$i" == "-l" ]]; then
				optList=1
				shift
			fi
		done

		currentbranch=`(realgit branch | grep \* | sed 's/.* //g' | sed 's/(\|)//g')`
		mergecommit=`(realgit merge-base $currentbranch $mergebranch)`
		if [[ "$?" -ne 0 ]]; then
			return 1
 		fi

		if [[ $optCommit -eq 1 ]] ; then
			echo ""
			echo "Current Branch: " $currentbranch
			realgit show -s --format=%ci $currentbranch $@
			realgit log --oneline --ancestry-path $mergecommit..$currentbranch $@
			echo ""
			echo "Merge Branch: " $mergebranch " @ " $mergecommit
			realgit show -s --format=%ci $mergecommit $@
			realgit log --oneline $mergecommit -1 $@
		fi
		if [[ $optList -eq 1 ]] ; then
			trashfile=/tmp/`randomstring`
			realgit diff --stat $mergecommit $currentbranch $@ > $trashfile
			echo ""
			echo "FILES"
			cat $trashfile
			rm $trashfile
		fi

		if [ \( $optCommit -eq 0 -a $optList -eq 0 \) ] ; then
			realgit diff $mergecommit $@
		fi

		return 0
	fi

	if [[ "$cmd" == "fullstatus" ]]; then
		realgit status "$@"
		return 0
	fi 

	if [[ ( "$cmd" == "diff" && "$1" == "-v" ) ]] ; then
		trashfile=/tmp/`randomstring`
		realgit -c color.status=false status -s > $trashfile
		sed -i '/^M */d' $trashfile # Modified
		sed -i '/^A */d' $trashfile # Added 
		sed -i '/^D */d' $trashfile # Deleted
		sed -i 's/.* //g' $trashfile
		cat $trashfile
		vim -p `cat $trashfile`
		rm $trashfile
		return 0
	fi

	if [[ ("$cmd" == "status") ]] ; then
		echo "Ignoring submodules.."
		realgit status --no-ahead-behind --ignore-submodules "$@"
		return 0
	fi	

	if [[ ("$cmd" == "pull") ]] ; then
		shift
		realgit fetch
		realgit pull --rebase --prune "$@"
		git sb
		return 0
	fi

	realgit $cmd "$@"
	return $?
}
