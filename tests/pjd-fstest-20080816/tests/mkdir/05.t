#!/bin/sh
# $FreeBSD: src/tools/regression/fstest/tests/mkdir/05.t,v 1.1 2007/01/17 01:42:09 pjd Exp $

desc="mkdir returns EACCES when search permission is denied for a component of the path prefix"

dir=`dirname $0`
. ${dir}/../misc.sh

echo "1..7"

n0=`namegen`
n1=`namegen`
n2=`namegen`

expect 0 mkdir ${n0} 0755
cdir=`pwd`
cd ${n0}
expect 0 mkdir ${n1} 0755
expect 0 chown ${n1} 65534 65534

if [ "$fs" != "zrtfs" ] #uid,gid does not supported by zrtfs; excluded 2 tests
then
    expect 0 -u 65534 -g 65534 mkdir ${n1}/${n2} 0755
    expect 0 -u 65534 -g 65534 rmdir ${n1}/${n2}
fi

expect 0 chmod ${n1} 0644 #4
expect 0 chmod ${n1} 0755

if [ "$fs" != "zrtfs" ] #uid,gid does not supported by zrtfs; excluded 3 tests
then
    expect EACCES -u 65534 -g 65534 mkdir ${n1}/${n2} 0755 #5
    expect 0 -u 65534 -g 65534 mkdir ${n1}/${n2} 0755
    expect 0 -u 65534 -g 65534 rmdir ${n1}/${n2}
fi
expect 0 rmdir ${n1}
cd ${cdir}
expect 0 rmdir ${n0}
