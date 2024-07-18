#!/usr/bin/env bash
#
# Wrapper script helps to consolidate per-platform configuration.
#

BS_PREFIX="${HOME}/pkg"
BS_UNPRIVILEGED="--unprivileged"

case "$(uname)" in
CYGWIN*)
	PATH=/cygdrive/c/tools/cygwin/bin
	;;
*BSD)
	BS_PREFIX=/usr/pkg
	BS_UNPRIVILEGED=
	;;
esac

cd ${GITHUB_WORKSPACE}/bootstrap
./bootstrap \
	--binary-kit=${HOME}/bootstrap.tar \
	--make-jobs=4 \
	--prefix=${BS_PREFIX} \
	${BS_UNPRIVILEGED} \
	--workdir=${HOME}/wrkdir
