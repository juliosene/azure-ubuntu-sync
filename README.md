# azure-ubuntu-sync
Sync local Linux shared path with a VM Linux on Azure

## Requirements:

First of all, create an Azure VM running Ubuntu Linux. Remember: username, password and IP address to logon on this VM.
Install (as root):
```
# To send e-mail notifications
apt-get install mailutils
# To notify when new files are coming.
sudo apt-get install inotify-tools
# To install Java (version 8)
add-apt-repository ppa:webupd8team/java
apt-get update
apt-get install oracle-java8-installer
```
## Usage:

On your local Linux Ubuntu machine, logon as root user, copy the main script and execute it.

```
wget https://raw.githubusercontent.com/juliosene/azure-ubuntu-sync/master/on-prime-autoconfig.sh
bash on-prime-autoconfig.sh
```

This script will create a shared folder called "AzureVideos" in your Linux local machine. This folder will be synced with a folder in your Azure VM.


