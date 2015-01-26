#!/bin/bash
##############################################################
#  Copyright (C) 2004 by Christoph Thielecke
#  crissi99@gmx.de
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the
#  Free Software Foundation, Inc.,
#  59 Temple Place - Suite 330, Boston, MA 02111-1307, USA
#
# checks if the ping answer was sucessful within given times
#
# syntax: ping_check.sh <ping cmd> <ping host ip> <interval in sec> <test ping count> <verbose>
# example: ping_check.sh /usr/bin/ping 192.168.1.1 1 4 0
#
##############################################################

PING=`which ping`
PINGHOST=$1
INTERVAL=$2
TEST_PING_COUNT=$3
QUIET=$4

if [  $QUIET -eq '1' ]; then
echo "Configuration:"
echo "Host: "$PINGHOST
echo "PING count: "$TEST_PING_COUNT
echo "Interval: "$INTERVAL
echo "- - - - -"
echo
fi

while true; do
fails=0
count=0
while [ $count -lt $TEST_PING_COUNT ]; do

if [  $QUIET -eq '1' ]; then
echo -n "Ping sequence "$count": "
fi
if [[ -z `ping -c 1 -w 5 $PINGHOST 2>&1 | grep '1 received'` ]]; then
        fails=`expr $fails + 1`
				if [  $QUIET -eq '1' ]; then
        echo "failed!"
				fi
else
				if [  $QUIET -eq '1' ]; then
        echo "ok."
				fi
fi
count=`expr $count + 1`
sleep $INTERVAL
done

if [  $QUIET -eq '1' ]; then
echo -n "PING failitures: "$fails" => "
fi
if [[ $fails > `expr $TEST_PING_COUNT - 1` ]]; then
        echo "PING failed!"

else
        echo "PING ok."
fi

done

