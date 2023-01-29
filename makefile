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
	
	
	

