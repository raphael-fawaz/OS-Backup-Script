# OS Lab2 (Raphael Guirguis ID:7252)
##Overview
It is a backup program, using the linux make command, a backup application will be put in to run and hence backups will be made regularly for the specified directory.
The main directory [7252-lab2] contains 2 directories the [test] directory and the backup directory [btest]. It also contains the [backupd.sh] which is the bash script code and the [makefile] in addition to this [readme] file.

##Usage
```bash
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
```
This part of the code takes from the user the directory to be backed up name and the backup directory name in addition to the frequency by which the user desires the directory to be backed up and the maximum number of backups to be stored.

The first backup is then made and thus the counter is set to 1

```bash
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
```

In this while loop that checks every interval if the directory has been modified or not. If so, we check if the counter exceeded the maximum backups specified by the user, if so we remove the olded backup, then a new backup is done and the counter is incremented again.


```bash
dirc?= $(shell bash -c 'read -p "Dir: " dir; echo $$dir')
bdir ?= $(shell bash -c 'read -p "Backupdir: " bdir; echo $$bdir')
interval ?= $(shell bash -c 'read -p "Interval: " intervalr; echo $$interval')
max ?= $(shell bash -c 'read -p "Maxbackups: " maxb; echo $$maxb')

.PHONY = all	
all: backup
	
prebuild:
	mkdir -p btest

backup:prebuild
	./backupd.sh $(dirc) btest $(interval) $(max)
	
clean:
	rm -r btest
	
```
In the previous makefile we urge the user to pass the name of the parameters then the [prebuild] part is used to create the backup file if not already created. Then in the [backup] part we execute our program.

## Bonus part
The bonus part will be found in the bonus directory
