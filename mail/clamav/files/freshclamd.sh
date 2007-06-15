#!@RCD_SCRIPTS_SHELL@
#
# $NetBSD: freshclamd.sh,v 1.4 2007/06/15 22:31:39 wiz Exp $
#
# PROVIDE: freshclamd
# REQUIRE: DAEMON LOGIN clamd

name="freshclamd"
rcvar=$name
command="@PREFIX@/bin/freshclam"
required_files="@PKG_SYSCONFDIR@/freshclam.conf"
pidfile="@VIRUSDBDIR@/${name}.pid"
freshclamd_user="@CLAMAV_USER@"
freshclamd_flags=${freshclamd_flags:=-c 2}
command_args="-d -p $pidfile"

. /etc/rc.subr

load_rc_config $name
run_rc_command "$1"
