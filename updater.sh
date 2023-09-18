#!/bin/bash

logger -p local0.debug -it tumlab_update_system "Start tumlab update process"

path_find_patch="/syncthing/patch/"
logger -p local0.debug -it tumlab_update_system "Variables values: path to find patch: $path_find_patch" 

history_patches="/apps/history_patches/"

log_path="/syncthing/log_execution_updater.log"
logger -p local0.debug -it tumlab_update_system "Variables values: path to save patches hystory: $history_patches"

checkExitsFile() {
    logger -p local0.debug -it tumlab_update_system "Using function check if exist file. File to check: $1"
    file="$1"
    retval=""
    if [[ -f "$file" ]]; then
        retval="true"
        logger -p local0.debug -it tumlab_update_system "File exists?: $retval"
    else
        retval="false"
        logger -p local0.debug -it tumlab_update_system "File exists?: $retval"
    fi
    echo $retval
}

count_patch=$(ls "$path_find_patch" | wc -l)

logger -p local0.debug -it tumlab_update_system "Validating new patches"

echo "$count_patch"
  
if [[ "$count_patch" = 0 ]]; then

    echo "No patches available"
    logger -p local0.debug -it tumlab_update_system "No patches available"
else

    find $path_find_patch -type f -iname "*.zip" > temp.txt

    while IFS= read -r line
    do
        echo "Installing patch"
        logger -p local0.debug -it tumlab_update_system "New patches available"
        logger -p local0.debug -it tumlab_update_system "Installing patch"

        patch_file=$line

        unzip "$patch_file" -d "$path_find_patch"
        logger -p local0.debug -it tumlab_update_system "Unzipping patch folder"

        # patch_folder=$(find "$path_find_patch"* -type d)
        file_name=$(echo "$line" | awk -F '/' '{print $4}'| awk -F '.' '{print $1}')
        patch_folder="$path_find_patch/$file_name"
        echo "$patch_folder"

        patch_exec_file="$patch_folder/init.sh"
        exist_init=$(checkExitsFile "$patch_exec_file")
        if [[ $exist_init == 'false' ]]; then
            logger -p local0.debug -it tumlab_update_system "No init file"
            echo "No init file"
            rm -r "$patch_folder"
        else
            echo "Execute init file"
            logger -p local0.debug -it tumlab_update_system "Execute init file $patch_exec_file"
            chmod +x "$patch_exec_file"
            echo "$patch_exec_file"
            $patch_exec_file >> $log_path
            check_error="$?"
            logger -p local0.debug -it tumlab_update_system "Checking error to execute init file. Exit code:$check_error"
            echo "$check_error"
            if [[ check_error -eq 0 ]]; then

                logger -p local0.debug -it tumlab_update_system "Successful patch installation"
                cp "$patch_file" "$history_patches"
                logger -p local0.debug -it tumlab_update_system "Copying patch files in the history folder patches"
                rm "$patch_file"
                rm -r "$patch_folder"
                logger -p local0.debug -it tumlab_update_system "Deleting patches file to syncthing folder"
            else
                echo "Error installing patch"
                logger -p local0.debug -it tumlab_update_system "Error installing patch. Exit code=$check_error"
                rm -r "$patch_folder"
                break

            fi

        fi
        
    done < temp.txt
    rm temp.txt

fi
logger -p local0.debug -it tumlab_update_system "End tumlab update process"