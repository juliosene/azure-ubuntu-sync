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
   mail -s "Your file $1 was completely received" $MAILTO < /home/$USERNAME/.verify/$1;
   if [ $extension = "mp4" ]; then
      VIDEOLINK=`java -jar videosync.jar videosync zlnnVE3dw4OZygNePUsSpd7pmeUMWd5RFdZTTn2nsvo= $1 /home/$USERNAME/videos/`
      cat /home/$USERNAME/mailtemplate.html | sed "s,##VIDEOLINK##,$VIDEOLINK,g;s,##VIDEONAME##,$1,g" | mail -s "$(echo -e "Your video $1 was published\nContent-Type: text/html")" $MAILTO
   fi
   rm /home/$USERNAME/.verify/$1
fi
