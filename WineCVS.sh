#!/bin/bash
###############################################################################
#                                                                             #
# WineCVS - A shell script that automates installation and                    #
# management of various wine flavours from CVS.                               #
#                                                                             #
# Copyright (C) 2004-2005 Lars Eriksen <le@ting.homeunix.org>                 #
#                         Andreas Schneider <mail@cynapses.org>               #
#                                                                             #
# This program is free software; you can redistribute it and/or               #
# modify it under the terms of the GNU General Public License                 #
# as published by the Free Software Foundation; either version 2              #
# of the License, or (at your option) any later version.                      #
#                                                                             #
# This program is distributed in the hope that it will be useful,             #
# but WITHOUT ANY WARRANTY; without even the implied warranty of              #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the               #
# GNU General Public License for more details.                                #
#                                                                             #
# You should have received a copy of the GNU General Public License           #
# along with this program; if not, write to the Free Software                 #
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA. #
#                                                                             #
###############################################################################

# important vars - use these to make automated profile scripts
WineCVShttpSource="http://winecvs.linux-gamers.net/WineCVS"
unset DefaultProfile # setting this to a profile name will make it use this if none other is given

# This is the frontend script
# ----------------------------

clear
User=$(id -un)                          # User who runs the script
Group=$(id -gn)                         # Group who runs the script
LauncherName=$(basename "$0")
HomeDir="$HOME/.WineCVS"
FunctionDir="$HomeDir/Functions"
ProfileDir="$HomeDir/Profiles"
CancelColor="\033[0m"
ErrorColor="\033[0;31m" #Red!

test -n "$DISPLAY" -a "$TERM" == "linux" && RunsInX="1" || unset RunsInX

# Functions
# ----------

function Alert()
{
	test -n "$RunsInX" -a -n "`which xkbbell 2>/dev/null`" && ALERT="xkbbell" || ALERT='echo -en \a'
	
	Times=$1
	
	while test "$Times" -gt "0"
	do
		$ALERT
		sleep "0.5"
		Times=$[$Times-1]
	done
	
	return 0
}

function Error()
{
	Alert 3
	echo -e "${ErrorColor}$1${CancelColor}\n\n"
	exit
}


# get the default stuff
# ----------------------

unset Upgrade
test "$1" == "upgrade" && Upgrade="yes" && shift

if test "$1" = "proxy"
then
	mkdir "$HomeDir" &>/dev/null
	echo "Enter proxy (eg: proxy.pandora.be:8080):"
	read http_proxy
	echo "$http_proxy" > "$HomeDir/.http_proxy" && echo "info stored ..."
	exit
fi

http_proxy=`cat "$HomeDir/.http_proxy" 2>/dev/null`
test -n "$http_proxy" && export http_proxy

if ! test -d "$HomeDir" -a -e "$FunctionDir/Defaults" -a -e "$FunctionDir/MainMenu" -a -z "$Upgrade"
then
	mkdir "$HomeDir" &>/dev/null
	mkdir "$FunctionDir" &>/dev/null
	mkdir "$ProfileDir" &>/dev/null
	test -d "$HomeDir" || Error "Could not make $HomeDir dir"
	
	cd "$HomeDir"

	echo -e "Fetching default scripts:\n\n"

	rm -f defaults.tar.gz

	wget "$WineCVShttpSource/defaults.tar.gz" || Error "Fetching failed!"
	
	
	echo -e "\nExtracting..."
	tar -zxf defaults.tar.gz && rm -f defaults.tar.gz || Error "Failed extracting!"
	echo "Done"

fi 

. "$FunctionDir/Defaults"  # default include

# test for likely X mode
if SetupRunTerm 2>/dev/null
then

	export WineCVShttpSource
	unset BASH_ENV
	
	$RunTerm bash --noprofile --norc -c "
	LauncherName=\"$LauncherName\"
	DefaultProfile=\"$DefaultProfile\"
	. \"$FunctionDir/Defaults\"  # default include
	# -- disabled for testing - important for launcher script ... WineCVShttpSource=\"$WineCVShttpSource\"
	RunsInX=\"1\"
	
	test -z \"\$WineCVShttpSource\" && Error \"Var export error - notify ElmerFudd on irc://irc.freenode.net, #Cedega\"
	
	. \"$FunctionDir/MainMenu\"
	"
 else
	. "$FunctionDir/MainMenu"
fi

