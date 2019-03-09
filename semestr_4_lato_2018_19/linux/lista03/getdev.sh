#! /usr/bin/sh

parse_fstab () {
    field=`cat /etc/fstab | grep --regexp ".*$1\/* " | awk -v IDX=$2 -F '\t' '{print $IDX}'`
}

parse_fstab $1 1
echo Device: $field

parse_fstab $1 2
echo Filesystem type: $field

parse_fstab $1 3
echo Mount options: $field

parse_fstab $1 4
echo Dump frequency: $field

parse_fstab $1 5
echo Fsck pass number: $field
