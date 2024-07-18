#!/usr/bin/env bash

set -x
uname
pwd
ls
env
cd ${GITHUB_WORKSPACE}/bootstrap
./bootstrap --prefix=${HOME}/pkg --unprivileged --binary-kit=/tmp/bootstrap.tar || true
find /cygdrive/d/a/pkgsrc/pkgsrc/bootstrap/work
cat /cygdrive/d/a/pkgsrc/pkgsrc/bootstrap/work/bmake/config.log
ls /cygdrive/d/a/pkgsrc/pkgsrc/bootstrap/work/bmake/main.c
head /cygdrive/d/a/pkgsrc/pkgsrc/bootstrap/work/bmake/main.c
false
