USERNAME="videosync"
inotifywait -m /home/$USERNAME/videos/ -e create -e moved_to -e close_write |
    while read path action file; do
        # echo "The file '$file' appeared in directory '$path' via '$action'"
         if [ "$action" = "MOVED_TO" ]; then md5sum /home/$USERNAME/$file > /home/$USERNAME/.verify/$file;  fi
    done
