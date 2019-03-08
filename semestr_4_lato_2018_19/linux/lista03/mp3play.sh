#! /usr/bin/sh

while true; do
    IFS="
"
    PS3="Wybierz numer>> "
    select idx in $(mp3info -p "%l (%a): %t\n" ~/mp3/*.mp3 | xargs -I {} echo {}); do
        if [ $idx ]; then
            ls ~/mp3/*.mp3 | head -n $REPLY | tail -n 1 | xargs -I {} mpv {} > /dev/null
        else echo zły wybór!
        fi
    done
done
