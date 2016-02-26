USERNAME="videosync"
inotifywait -m /home/$USERNAME/videos/ -e create -e moved_to -e close_write |
    while read path action file; do
        # echo "The file '$file' appeared in directory '$path' via '$action'"
         if [ "$action" = "MOVED_TO" ]; then md5sum /home/$USERNAME/videos/$file > /home/$USERNAME/.verify/$file; echo "/bin/bash /home/$USERNAME/verify.sh $file"|at -m now + 2min; fi
#         if [ "$file" = "acabou.txt" ]; then echo "Terminou"; fi
        # do something with the file
    done
