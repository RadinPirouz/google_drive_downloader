#!/bin/bash


echo "Enter Google Drive Link: "
read link
echo "Enter File Name: "
read filename
test="test"
fileid=`echo $link | awk  'gsub("&export=download", "", $0)' | grep -Po 'id=\K[^"]*'`
final_link="https://drive.google.com/uc?id=${fileid}&export=download&confirm=yes"
echo $final_link
curl -o ${filename} -L $final_link
