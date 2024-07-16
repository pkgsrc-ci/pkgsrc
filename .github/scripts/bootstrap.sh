#!/usr/bin/env bash
#
# Wrapper script helps to consolidate per-platform configuration.
#

case "$(uname)" in
CYGWIN*)
	PATH=/cygdrive/c/tools/cygwin/bin
	BINARY_KIT=$(cygpath ${GITHUB_WORKSPACE})/bootstrap.tar
	;;
*)
	BINARY_KIT=${GITHUB_WORKSPACE}/bootstrap.tar
	;;
esac

cat >${HOME}/bootstrap-include.mk <<EOF
MAKE_JOBS=4
EOF

cd ${GITHUB_WORKSPACE}/bootstrap
./bootstrap \
	--binary-kit=${BINARY_KIT} \
	--make-jobs=4 \
	--mk-fragment=${HOME}/bootstrap-include.mk \
	--prefix=${HOME}/pkg \
	--unprivileged \
	--workdir=${HOME}/wrkdir
