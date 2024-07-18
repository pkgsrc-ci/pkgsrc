#!/usr/bin/env bash
#
# Wrapper script helps to consolidate per-platform configuration.
#

case "$(uname)" in
CYGWIN*)
	PATH=/cygdrive/c/tools/cygwin/bin
	;;
esac

cd ${GITHUB_WORKSPACE}/bootstrap
./bootstrap \
	--binary-kit=${HOME}/bootstrap.tar \
	--make-jobs=4 \
	--prefix=${HOME}/pkg \
	--unprivileged \
	--workdir=${HOME}/wrkdir
