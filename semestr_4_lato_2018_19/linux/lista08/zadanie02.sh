for idx in `seq $1`; do
    (stress -c 1)&
done
