#!/bin/sh
export PATH=/usr/bin

if [ "$1" != "stop" ]; then

  ROOTDEV=`findmnt -v -o SOURCE -n -M /`

  echo "Checking root file system (^C to skip)..."
  if [ -x /usr/bin/fsck ]; then
    /usr/bin/fsck -C -a "$ROOTDEV"
    fsckresult=$?
    if [ $((fsckresult & 4)) -eq 4 ]; then
      echo "***********************"
      echo "WARNING WARNING WARNING"
      echo "***********************"
      echo "The root file system has problems which require user attention."
      echo "A maintenance shell will now be started; system will then be rebooted."
      /usr/bin/sulogin
      /usr/bin/reboot --use-passed-cfd -r
    elif [ $(($fsckresult & 2)) -eq 2 ]; then
      echo "***********************"
      echo "WARNING WARNING WARNING"
      echo "***********************"
      echo "The root file system had problems (now repaired): rebooting..."
      sleep 5
      /usr/bin/reboot --use-passed-cfd -r
    fi
  else
    echo "WARNING - Could not find /usr/bin/fsck"
  fi

fi;
