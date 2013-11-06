dnl
dnl Require autoconf version 2.50 or greater
dnl
dnl Copyright (C) 2004, 2006, 2008 Rocky Bernstein <rocky@gnu.org>
dnl
dnl This program is free software; you can redistribute it and/or modify
dnl it under the terms of the GNU General Public License as published by
dnl the Free Software Foundation; either version 2, or (at your option)
dnl any later version.
dnl
dnl This program is distributed in the hope that it will be useful,
dnl but WITHOUT ANY WARRANTY; without even the implied warranty of
dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
dnl GNU General Public License for more details.
dnl
dnl You should have received a copy of the GNU General Public License
dnl along with this program; if not, write to the Free Software
dnl Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  
dnl 02110-1301  USA.

dnl $Id: configure.ac,v 1.43 2008/12/25 16:42:49 rockyb Exp $
dnl Process this file with autoconf to produce a configure script.

AC_INIT(ps-watcher.in.in)
AM_INIT_AUTOMAKE(ps-watcher,1.07)

AM_MISSING_PROG(CVS2CL, cvs2cl, $missing_dir)
AM_MAINTAINER_MODE
AC_CANONICAL_HOST

AC_PREREQ(2.10)dnl               dnl Minimum Autoconf version required.

dnl =============================
dnl Checks for programs.
dnl =============================
AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_MAKE_SET

AC_ARG_WITH(perl, AC_HELP_STRING([--with-perl], 
		  [set path to Perl]), PERL=$withval)

## We use a path for perl so the #! line in autoscan will work.
AC_PATH_PROG(PERL, perl, no)

if test "$PERL" = no; then
  AC_MSG_ERROR(Pssst... you need perl in order to use this program.\
  Install it or put it in your path and try again.)
fi

AC_SUBST(PERL)dnl

AC_PATH_PROG(PS, ps, no)
AC_SUBST(PS)dnl

## PS_ARGS gives how we get the command line for a given PID. Also see 
## description for PS_VARS.
AC_SUBST(PS_ARGS)

AC_SUBST(PS_ARGS_FMT)
AC_SUBST(PS_FULLCMD_FMT)

## PS_NO_NULL_HEADER indicates that we can't get rid of the PS header line
AC_SUBST(PS_NO_NULL_HEADER)

## PS_CAN_RETURN_MULTIPLE_LINES indicates the ps on this OS can return 
## multiple lines for a process. Solaris's ps does this for processes
## which have many lwp (light-weight processes).
AC_SUBST(PS_CAN_RETURN_MULTIPLE_LINES)

## PS_CUSTOM_HEADER specifies whether we can put an = after the argument
## name to remove the header for that variable
AC_SUBST(PS_CUSTOM_HEADER)

## PS_PID_OPTS gives how to get the pid and command name needed for
##l first-level breakout.
AC_SUBST(PS_PID_OPTS)

## PS_TIME_VAR gives a variable that we can test time on
AC_SUBST(PS_TIME_VAR)

## PS_VAR gives a list of the PS variables we can query.
## However we must use only those variables that give output as a single
## token since these are parsed one token per variable. For example
## the arguments (args, or comm, or command) shouldn't be listed here.
AC_SUBST(PS_VARS)

## ========================================================================
## Need a better way to figure out ps options and to know
## which ones don't have embeded blanks or to parse ps output.
## ========================================================================
PS_ARGS_FMT=''
PS_FULLCMD_FMT=''
PS_TIME_VAR=''

case "$host_os" in
  aix* ) 
    PS_ARGS='-o args='
    PS_CAN_RETURN_MULTIPLE_LINES=0
    PS_CUSTOM_HEADER=1
    PS_NO_NULL_HEADER=0
    PS_PID_OPTS='-e -o pid= -o comm='
    PS_TIME_VAR='etime'
    PS_VARS='user ruser group rgroup uid ruid gid rgid ppid
pgid pri cpu pcpu pmem vsz nice class scount thcount tid time 
etime tty wchan bnd'
    ;;
  cygwin* ) 
    PS_ARGS='-l | cut -c 2-10,56-120'
    PS_ARGS_FMT=['$opts{ps_prog} -l |cut -c 2-10,56-120|egrep \"^[ \\t]*%d\"']
    PS_FULLCMD_FMT=['$opts{ps_prog} -l|cut -c 2-47,56-120|egrep \"^[ \\t]*%d\"']
    PS_CAN_RETURN_MULTIPLE_LINES=0
    PS_CUSTOM_HEADER=0
    PS_NO_NULL_HEADER=1
    PS_PID_OPTS='-l | cut -c 2-10,56-120'
    PS_VARS='pid ppid pgid winpid tty uid'
    ;;
  solaris* ) 
    PS_ARGS='-o args='
    PS_CAN_RETURN_MULTIPLE_LINES=1
    PS_CUSTOM_HEADER=1
    PS_NO_NULL_HEADER=0
    PS_PID_OPTS='-e -o pid= -o comm='
    PS_TIME_VAR='etime'
    PS_VARS='user ruser group rgroup uid ruid gid rgid ppid
pgid sid pri pcpu pmem vsz rss osz nice class time
etime stime f s lwp nlwp psr tty addr wchan fname'
    ;;
  linux* ) 
    PS_ARGS='-www -o args='
    PS_CAN_RETURN_MULTIPLE_LINES=0
    PS_CUSTOM_HEADER=1
    PS_NO_NULL_HEADER=0
    PS_PID_OPTS='-e -o pid= -o cmd='
    # Make sure we put known single tokens at the beginning like uid.
    PS_VARS='uid euid ruid gid egid rgid alarm blocked bsdtime c caught
cputime drs dsiz egroup eip esp etime euser f fgid
fgroup flag flags fname fsgid fsgroup fsuid fsuser fuid fuser
group ignored intpri lim longtname m_drs m_trs maj_flt majflt
min_flt  minflt ni nice nwchan opri pagein pcpu pending pgid pgrp
pmem ppid pri rgroup rss rssize rsz ruser s sess session
sgi_p sgi_rss sgid sgroup sid sig sig_block sig_catch sig_ignore
sig_pend sigcatch sigignore sigmask stackp start start_stack start_time
stat state stime suid suser svgid svgroup svuid svuser sz time timeout
tmout tname tpgid trs trss tsiz tt tty tty4 tty8 uid_hack uname
user vsize vsz wchan'
    PS_TIME_VAR='etime'
    ;;
  netbsdelf2* | openbsd* ) 
    PS_ARGS='-o args'
    PS_CAN_RETURN_MULTIPLE_LINES=0
    PS_CUSTOM_HEADER=0
    PS_NO_NULL_HEADER=1
    PS_PID_OPTS='-a -x -o pid= -o ucomm='
    PS_VARS='acflag cpu f \
inblk jobc ktrace ktracep lim login majflt minflt msgrcv
msgsnd nice nivcsw nsigs nswap nvcsw nwchan oublk p_ru
paddr pagein pid ppid pri re rgid rlink rss rsz
ruid ruser sess sig sigcatch sigignore sigmask sl start state
svgid svuid tdev time tpgid tsess tsiz tt tty ucomm uid upr user vsz
wchan xstat'
    PS_TIME_VAR='cpu'
    ;;	
  netbsd* | freebsd4* ) 
    PS_ARGS='-O command'
    PS_CAN_RETURN_MULTIPLE_LINES=0
    PS_CUSTOM_HEADER=0
    PS_NO_NULL_HEADER=1
    PS_PID_OPTS='-a -x -o pid= -o ucomm='
    PS_VARS='acflag cpu cputime f
inblk jobc ktrace ktracep lim login majflt minflt msgrcv
msgsnd nice nivcsw nsigs nswap nvcsw nwchan oublk p_ru
paddr pagein pid ppid pri re rgid rlink rss rsz
ruid ruser sess sig sigcatch sigignore sigmask sl start state
svgid svuid tdev time tpgid tsess tsiz tt tty ucomm uid upr user vsz
wchan xstat'
    PS_TIME_VAR='cputime'
    ;;	
  bsdi4* ) 
    PS_ARGS='-www -o command'
    PS_CAN_RETURN_MULTIPLE_LINES=0
    PS_CUSTOM_HEADER=0
    PS_NO_NULL_HEADER=1
    PS_PID_OPTS='-a -x -o pid= -o ucomm='
    PS_TIME_VAR='cputime'
    PS_VARS='acflag cpu cputime f \
inblk jobc ktrace ktracep lim login
nice nivcsw nsigs nswap nvcsw nwchan oublk p_ru
paddr pagein pid ppid pri re rgid rlink rss rsz
ruid ruser sess sig sigcatch sigignore sigmask sl start state
svgid svuid tdev time tpgid tsess tsiz tt tty ucomm uid upr user vsz
wchan xstat'
    ;;	
 darwin5* | darwin6* | darwin7* | darwin8* | darwin9* )
    PS_PID_OPTS='-a -x -o pid= -o ucomm'
    PS_VARS='acflag cpu cputime f 
inblk jobc ktrace ktracep lim login uid upr user vsz
nice nivcsw nsigs nswap nvcsw nwchan oublk p_ru
paddr pcpu pagein pid ppid pri re rgid rss rsz 
ruid ruser sess sig sigmask sl start state
svgid svuid tdev time tpgid tsess tsiz tt tty ucomm 
wchan xstat'
    PS_TIME_VAR='cputime'
    PS_ARGS='-www -o command'
    PS_NO_NULL_HEADER=1
    PS_CUSTOM_HEADER=0
    PS_CAN_RETURN_MULTIPLE_LINES=0
    ;;	
  * ) 
    echo "Don't know $host_os. Winging it."
    PS_ARGS=''
    PS_CAN_RETURN_MULTIPLE_LINES=0
    PS_CUSTOM_HEADER=0
    PS_NO_NULL_HEADER=1
    PS_PID_OPTS='-e -o pid= -o comm='
    PS_VARS='user ruser group rgroup uid ruid gid rgid ppid \
pgid sid pri pcpu pmem vsz rss osz nice class time \
etime stime tty addr wchan fname'
    PS_TIME_VAR='etime'
esac

AC_CONFIG_FILES([post-configure],  [chmod +x post-configure])
AC_CONFIG_FILES([tests/01.pod.t],  [chmod +x tests/01.pod.t])
AC_CONFIG_FILES([tests/args.t],    [chmod +x tests/args.t])
AC_CONFIG_FILES([tests/basic.t],   [chmod +x tests/basic.t])
AC_CONFIG_FILES([tests/count.t],   [chmod +x tests/count.t])
AC_CONFIG_FILES([tests/full.t],    [chmod +x tests/full.t])
AC_CONFIG_FILES([ps-watcher.in])
AC_CONFIG_FILES([ps-watcher],      [./post-configure $srcdir || exit 3])

AC_OUTPUT([ 
       Makefile \
       docs/Makefile \
       tests/basic.cnf \
       tests/Makefile \
])
