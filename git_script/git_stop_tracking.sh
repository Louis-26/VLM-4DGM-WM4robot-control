cd $(git rev-parse --show-toplevel)

# uncomment if it is in linux, and need to convert dos to unix
# sed -i 's/\r$//' git_script/git_stop_tracking.sh
# this script is used to stop tracking files or folders
while true; do
	read -p "Enter the name of file/folder you want to stop tracking, or directly enter to exit: " FILE_NAME

	if [ "$FILE_NAME" == "" ]; then
		break
	fi

	# directory
	if [ -d "$FILE_NAME" ]; then
		# Directory - add all files in it
		git rm -r --cached "$FILE_NAME"
		if ! grep -Fxq "$FILE_NAME" .gitignore; then
			echo "\n/$FILE_NAME/" >>.gitignore
		fi

	# file
	elif [ -f "$FILE_NAME" ]; then
		git rm --cached "$FILE_NAME"
		if ! grep -Fxq "$FILE_NAME" .gitignore; then
			echo "$FILE_NAME" >>.gitignore
		fi

	else
		echo "'$FILE_NAME' not found as a file or folder, skipping"
	fi
done
