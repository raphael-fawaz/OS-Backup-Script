#!/bin/bash

dir=$1
backupdir=$2
intervalsec=$3
maxbackups=$4
currentdate=$(date '+%Y-%m-%d-%H-%M-%S')
mkdir $backupdir/$currentdate
counter=0

ls -IR $dir > $backupdir/directory-info.last
cp -r $dir $backupdir/$currentdate
counter=1
while true
do
	sleep $intervalsec
	ls -IR $dir > $backupdir/directory-info.new
	if cmp -s "$backupdir/directory-info.last" "$backupdir/directory-info.new";then
		echo "no backup needed"
	else
		
		if [ $counter -gt $maxbackups ]
		then
			echo "# of backups exceeded, a backup is removed"
			rm -r $backupdir/"$(ls $backupdir | head -1)"
		fi
		counter=$(( $counter + 1 ))
		echo "a new back up is done"
		currentdate=$(date '+%Y-%m-%d-%H-%M-%S')
		mkdir $backupdir/$currentdate
		cp -r $dir $backupdir/$currentdate
		ls -IR $dir > $backupdir/directory-info.last
	fi
		
done
