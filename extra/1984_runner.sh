#!/bin/bash

PATH=/usr/local/bin:$PATH

running=$(ps awx |grep "ruby.*runner.*LogAnalizer" |grep -v grep)


if [ -z "$running" ] ; then

        echo "LogAnalizer not running... restart"
        cd /var/www/1984
        ruby script/runner -e production LogAnalizer.realtime_analize &
        sleep 10
        echo "$(ps awx |grep "ruby.*runner.*LogAnalizer" |grep -v grep)"

else

        echo "LogAnalizer running..."

fi

