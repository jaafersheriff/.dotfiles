
function makeWorkspace() {
	if [ $# -lt 1 ]; then
		echo "Specify workspace name"
		return
	fi

	spacename=$1
	echo "Generating " $spacename
	mkdir $1
	cd $1
	cp -r ~/.funcs/baseWorkspace/workspace/* .
	echo "build/" >> .gitignore
	git init
	bash run -r
}
