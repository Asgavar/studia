#! /usr/bin/sh

howmany=0
# ostatni wiersz to 'total <liczba bajtów>'
total=`ls -l --sort=time $2 | tac | tail -n 1 | awk -F ' ' '{print $2}'`

while [[ $total -gt $1 ]]; do
    howmany=$((howmany + 1))
    total=`ls -l --sort=time $2 | tac | tail -n +$howmany| awk -F ' ' '{sum+=$5} END {print sum}'`
    # echo $total total
    # echo $howmany howmany
done

ls -l --sort=time $2 | tac | head -n $howmany
