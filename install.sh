#!/bin/bash

wget=/usr/bin/wget
tar=/bin/tar
base_url='http://storage.uplynk.com/software/'
if [ $(whoami) != 'root' ]; then
        echo "Must be root to run $0"
        exit 1;
      fi
echo "what Slicer Version do you want to use? i.e. 17071900"
read slicerversion
slicer=uplynk_slicer_linux_64-$slicerversion-master.tbz2
echo $slicer
WGET=`wget -o wgetstatus "$base_url$slicer"`
wgetstatus=`cat wgetstatus|awk '/HTTP/{print $6}'`
if [ $wgetstatus != 200 ]; then
  echo "Slicer Version Doesn't Exist"
  exit;
fi
#else echo "Downloading Slicer"
#fi
tar xvf "$slicer"
wait
rm -f "$slicer"
#echo $tar
slicer2=uplynk_slicer_linux_64-$slicerversion-master
cd "$slicer2"
./install_live
wait

#Gets Sinh's Scripts to running Multiple Slicers
wget https://www.dropbox.com/s/glh1btud42b2hsv/uplynk_liveslicer.conf?dl=0
wget https://www.dropbox.com/s/e1blyqkpkozoyid/uplynk.conf?dl=0
mv uplynk_liveslicer.conf?dl=0 /etc/init/uplynk_liveslicer.conf
mv uplynk.conf?dl=0 /etc/init/uplynk.conf

#Makes Uplynk Directory and files for Sinh Scripts
mkdir /etc/uplynk
touch uplynk
mv uplynk /etc/default

#Gets Rid of Dash to Bash
mv /bin/sh sh.bak
ln -s /bin/bash sh

#Asks user for number of slicers they want to run must be a number
echo  "How Many Slicers Do you want to run on this Server? i.e. 2"
read number_slicers
echo "Name the slicer id seperate each by a space, max 10 inputs i.e. input1 input2 input3 "
read  slicer1 slicer2 slicer3 slicer4 slicer5 slicer6 slicer7 slicer8 slicer9 slicer10

#Edits configuration for uplynk files
echo NUM_INSTANCES=$number_slicers >> /etc/default/uplynk
echo UPLYNK_CONF_DIR=/etc/uplynk >> /etc/default/uplynk
printf "SLICER_IDS=('$slicer1' '$slicer2' '$slicer3' '$slicer4' '$slicer5' '$slicer6' '$slicer7' '$slicer8' '$slicer9' '$slicer10' )" >> /etc/default/uplynk

#Creates configuration files based on names and moves to etc uplynk directory
touch $slicer1.conf
mv $slicer1.conf /etc/uplynk
touch $slicer2.conf
mv $slicer2.conf /etc/uplynk
touch $slicer3.conf
mv $slicer3.conf /etc/uplynk
touch $slicer4.conf
mv $slicer4.conf /etc/uplynk
touch $slicer5.conf
mv $slicer5.conf /etc/uplynk
touch $slicer6.conf
mv $slicer6.conf /etc/uplynk
touch $slicer7.conf
mv $slicer7.conf /etc/uplynk
touch $slicer8.conf
mv $slicer8.conf /etc/uplynk
touch $slicer9.conf
mv $slicer9.conf /etc/uplynk
touch $slicer10.conf
mv $slicer10.conf /etc/uplynk
echo "Please Edit the Configuration files located in /etc/uplynk then start the slicer instance"
