#!/bin/sh
export PATH=/usr/bin
export HOSTNAME=myhost

umask 0077

set -e

if [ "$1" != "stop" ]; then
    # cleanup
    # (delete /tmp etc)
    rm -rf /tmp/* /tmp/.[!.]* /tmp/..?*

    # empty utmp, create needed directories
    : > /var/run/utmp
    mkdir -m og-w /var/run/dbus

    # Configure random number generator
    if [ -e /var/state/random-seed ]; then
    cat /var/state/random-seed > /dev/urandom;
    fi

    # set the hostname
    echo "$HOSTNAME" > /proc/sys/kernel/hostname
    /usr/bin/hostname "$HOSTNAME"
else
    # The system is being shut down
    # echo "Saving random number seed..."
    POOLSIZE="$(cat /proc/sys/kernel/random/poolsize)"
    dd if=/dev/urandom of=/var/state/random-seed bs="$POOLSIZE" count=1 2>/dev/null
fi;
