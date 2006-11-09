#! /bin/sh
#		Written by Miquel van Smoorenburg <miquels@cistron.nl>.
#		Modified for Debian
#		by Ian Murdock <imurdock@gnu.ai.mit.edu>.
#
# Version:	@(#)skeleton  1.9  26-Feb-2001  miquels@cistron.nl
# /etc/init.d/ps-watcher: v1 2006/11/03 Jan Wagner <waja@cyconet.org>

### BEGIN INIT INFO
# Provides: ps-watcher
# Required-Start: $local_fs $network $remote_fs $syslog
# Required-Stop: $local_fs $network $remote_fs $syslog
# Default-Start:  2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: start and stop the ps-watcher daemon
# Description: monitoring a system via ps-like commands
### END INIT INFO

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
DAEMON=/usr/bin/ps-watcher
NAME=ps-watcher
DESC=ps-watcher

test -x $DAEMON || exit 0

# Include ps-watcher defaults if available
if [ -f /etc/default/ps-watcher ] ; then
	. /etc/default/ps-watcher
fi

set -e

not_configured () {
        echo "#### WARNING ####"
        echo "ps-watcher won't be started/stopped unless it is configured"
        if [ "$1" != "stop" ]
        then
                echo ""
                echo "Please pease provide a configfile!"
                echo "See /usr/share/doc/ps-watcher/README.Debian.gz."
        fi
        echo "#################"
        exit 0
}

# check if ps-watcher is configured or not
if [ -f "/etc/default/pswatcher" ]
then
        . /etc/default/ps-watcher
        if [ "$startup" != "1" ] || [ -f $CONFIG ]
        then
                not_configured
        fi
else
        not_configured
fi


case "$1" in
  start)
	echo -n "Starting $DESC: "
	start-stop-daemon --start --quiet --pidfile /var/run/$NAME.pid \
		--exec $DAEMON -- -c $CONFIG --daemon $DAEMON_OPTS
	echo "$NAME."
	;;
  stop)
	echo -n "Stopping $DESC: "
	start-stop-daemon --stop --quiet --pidfile /var/run/$NAME.pid \
		--exec $DAEMON
	echo "$NAME."
	;;
  restart|force-reload)
	echo -n "Restarting $DESC: "
	start-stop-daemon --stop --quiet --pidfile /var/run/$NAME.pid \ 
		--exec $DAEMON
	sleep 1
	start-stop-daemon --start --quiet --pidfile /var/run/$NAME.pid \
		 --exec $DAEMON -- -c $CONFIG --daemon $DAEMON_OPTS
	echo "$NAME."
	;;
  *)
	N=/etc/init.d/$NAME
	# echo "Usage: $N {start|stop|restart|reload|force-reload}" >&2
	echo "Usage: $N {start|stop|restart|force-reload}" >&2
	exit 1
	;;
esac

exit 0
