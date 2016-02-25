USERNAME="videosync"
         if [ "`md5sum /home/$USERNAME/videos/$1`" = "`cat /home/$USERNAME/.verify/$1 | head -n1`" ]; then echo "terminou" >> /home/$USERNAME/.verify/$1 ; fi

