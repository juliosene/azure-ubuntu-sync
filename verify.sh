# First of all, install mail tools
# apt-get install mailutils
USERNAME="videosync"
MAILTO="jufranca@microsoft.com"
if [ "`md5sum /home/$USERNAME/videos/$1`" = "`cat /home/$USERNAME/.verify/$1 | head -n1`" ]; then
   mail -s "Your file $1 was sent" $MAILTO < /home/$USERNAME/.verify/$1;
   rm /home/$USERNAME/.verify/$1
fi
