sudo mkdir /media/$USER
sudo mkdir /media/$USER/Depots
sudo chmod -R 777 /media/$USER/Depots
sudo mount /dev/sdb1 /media/$USER/Depots
mkdir /media/$USER/Depots
mkdir -p /media/$USER/Depots/miroir/{mirror,skel,var}
#configuration du apt-mirror
sudo cp /etc/apt/mirror.list /media/$USER/Depots/miroir/apt-mirror-configuration
mkdir -p /media/hel/Depots/miroir/dists/stretch/main/installer-amd64/current/images

