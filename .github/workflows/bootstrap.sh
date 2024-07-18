#!/usr/bin/env bash

set -x
uname
pwd
ls
env
cd ${GITHUB_WORKSPACE}/bootstrap
./bootstrap --prefix=${HOME}/pkg --unprivileged --workdir=${HOME}/wrkdir --binary-kit=/tmp/bootstrap.tar || true
mkdir /tmp/foo
echo hi >/tmp/foo/bar
find /cygdrive/d/a/pkgsrc/pkgsrc/bootstrap/work
cat /cygdrive/d/a/pkgsrc/pkgsrc/bootstrap/work/bmake/config.log
ls /cygdrive/d/a/pkgsrc/pkgsrc/bootstrap/work/bmake/main.c
head /cygdrive/d/a/pkgsrc/pkgsrc/bootstrap/work/bmake/main.c
false
