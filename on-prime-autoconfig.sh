#!/bin/bash
# Install rsync and samba to sync and share files

AZUREUSER=${1:-""}
AZUREPASSWORD=${2:-""}
AZURESERVER=${3:-""}
echo -n "Enter Azure Linux username: "
read AZUREUSER
# echo -n "Enter Azure Linux user password: "
# read AZUREPASSWORD
echo -n "Enter Azure Linux servername (DNS) or IP: "
read AZURESERVER

#if [ -z "$AZURESERVER" ]; then
#    echo "Usage: #on-prime-autoconfig.sh <azureusername> <azurepasword> <azureservernameorip> <*locausername*> <*localpassword*>"
#fi

cd ~
mkdir syncautoconfig
cd syncautoconfig
# apt-get update
# apt-get -fy dist-upgrade
# apt-get -fy upgrade
apt-get install lsb-release bc
REL=`lsb_release -sc`
DISTRO=`lsb_release -is | tr [:upper:] [:lower:]`

USERNAME=${1:-"videosync"}
USERPASSWORD=${2:-`date +%D%A%B | md5sum| sha256sum | base64| fold -w16| head -n1`}

## Creating user to sync
useradd -m $USERNAME

## Create keys to remote access
cd /home/$USERNAME
mkdir .ssh
chown $USERNAME .ssh
cd .ssh
ssh-keygen -t rsa -f /home/$USERNAME/.ssh/id_rsa -N ""
cp id_rsa.pub authorized_keys
chown $USERNAME.$USERNAME *
chmod 600 *

## Create user share dir (to replicate)
mkdir /home/$USERNAME/videos
chown -R $USERNAME.$USERNAME /home/$USERNAME/videos

## Prepare Azure server
scp authorized_keys $AZUREUSER@$AZURESERVER:/home/$AZUREUSER/
# ssh $AZUREUSER@$AZURESERVER "sudo useradd -m -s /bin/bash $USERNAME;echo $USERNAME:$USERPASSWORD |sudo chpasswd;sudo mkdir .ssh;sudo mv /home/$AZUREUSER/authorized_keys /home/$USERNAME/.ssh/;sudo chown -R $USERNAME.$USERNAME .ssh;sudo chmod 700 .ssh;sudo chmod 600 authorized_keys;sudo mkdir /home/$USERNAME/videos;sudo chown -R $USERNAME.$USERNAME /home/$USERNAME/videos;exit;"
ssh $AZUREUSER@$AZURESERVER "sudo useradd -m -s /bin/bash $USERNAME;echo $USERNAME:$USERPASSWORD |sudo chpasswd;sudo mv /home/$AZUREUSER/authorized_keys /home/$USERNAME/.ssh/;sudo chown -R $USERNAME.$USERNAME .ssh;sudo chmod 700 .ssh;sudo chmod 600 authorized_keys;sudo mkdir /home/$USERNAME/videos;sudo chown -R $USERNAME.$USERNAME /home/$USERNAME/videos;exit;"

## Create rsync
apt-get install -y rsync
echo "* *     * * *   root    rsync -Cravzp -e 'ssh -i /home/$USERNAME/.ssh/id_rsa' /home/$USERNAME/videos/ $USERNAME@40.76.212.21:/home/$USERNAME/videos/" >> /etc/crontab
