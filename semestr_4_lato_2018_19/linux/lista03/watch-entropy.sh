#! /usr/bin/sh

while true; do
    cat /proc/sys/kernel/random/{entropy_avail,poolsize} \
        | xargs -n 2 sh -c 'echo -n Available entropy: $0 bits of $1 available'
    echo -ne '\r'
    read -s -t 1 -N 1 key_pressed
    if [ $key_pressed ]; then
       exit
    fi
done
