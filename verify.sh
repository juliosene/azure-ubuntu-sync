# First of all, install mail tools
# apt-get install mailutils
#
USERNAME="videosync"
MAILTO="your@email.com"
#
filename=$(basename "$1")
extension="${filename##*.}"
filename="${filename%.*}"
#
if [ "`md5sum /home/$USERNAME/videos/$1`" = "`cat /home/$USERNAME/.verify/$1 | head -n1`" ]; then
   mail -s "Your file $1 was sent" $MAILTO < /home/$USERNAME/.verify/$1;
   if [ $extension = "mp4" ]; then
      java -jar videosync.jar videosync zlnnVE3dw4OZygNePUsSpd7pmeUMWd5RFdZTTn2nsvo= $1 /home/$USERNAME/videos/ > .videourl.txt
      mail -s "Your video $1 was published!" $MAILTO < .videourl.txt
   fi
   rm /home/$USERNAME/.verify/$1
fi
