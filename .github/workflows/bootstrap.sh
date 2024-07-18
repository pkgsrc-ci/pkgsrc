#!/usr/bin/env bash

set -x
find /cygdrive/c/tools/cygwin
PATH=/cygdrive/c/tools/cygwin/usr/bin:/cygdrive/c/tools/cygwin/bin
uname
pwd
ls
env
which gcc
type gcc
gcc -v
cd ${GITHUB_WORKSPACE}/bootstrap
./bootstrap --prefix=${HOME}/pkg --unprivileged --workdir=${HOME}/wrkdir --binary-kit=/tmp/bootstrap.tar || true
mkdir /tmp/foo
echo hi >/tmp/foo/bar
find $HOME/wrkdir/work
cat $HOME/wrkdir/work/bmake/config.log
ls $HOME/wrkdir/work/bmake/main.c
head $HOME/wrkdir/work/bmake/main.c
false
