#!/bin/sh
# $NetBSD: NetBSD.sh,v 1.4 1998/09/21 18:30:34 garbled Exp $

@@@PREFIX@@@/bin/perl util/perlpath.pl @@@PREFIX@@@/bin
@@@PREFIX@@@/bin/perl util/ssldir.pl @@@PREFIX@@@

case "$1" in
    i386)
	conf=NetBSD-x86
	;;
    sparc)
	conf=NetBSD-sparc
	;;
    m68k)
	conf=NetBSD-m86	# yes, this really IS m86, not m68!
	;;
    alpha)
	conf=NetBSD-alpha
	;;
    *)
	echo "Not supported on this architecture, sorry."
	;;
esac
@@@PREFIX@@@/bin/perl Configure $conf
