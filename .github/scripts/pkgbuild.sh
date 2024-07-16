#!/usr/bin/env bash
#
# Wrapper script to build a set of packages.
#

#
# Unpack bootstrap kit if we don't have it already unpacked from a previous
# build session.  Obviously requires that a prior step puts it in place.
#
if [ ! -d ${HOME}/pkg ]; then
	tar -xvf bootstrap.tar -C /
fi

# USE_BINPKG is set to true or false in the environment via input variables.
# BINPKG_SITES is set to the correct URL, all we do is ensure it's exported
# if we're using them, otherwise ensure it's unset.
if ${USE_BINPKG}; then
	export BINPKG_SITES
	export DEPENDS_TARGET=bin-install
else
	unset BINPKG_SITES
fi

PATH=$HOME/pkg/sbin:$HOME/pkg/bin:/usr/sbin:/sbin:/usr/bin:/bin

# INPUT_FILES contains a list of files that were modified by the commit for
# testing.  We extract a uniq list of package directories from it and build
# them.  This is pretty basic, no ordering or whatever, but it'll do for now.
for file in ${INPUT_FILES}; do
	echo ${file} | cut -d/ -f1,2
done | sort | uniq | while read dir; do
	(cd ${dir} && bmake install)
done
