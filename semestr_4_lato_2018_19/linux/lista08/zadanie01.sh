while true; do
    current_time=$(timedatectl)
    payload="żyję"
    echo $payload
    logger $payload
    sleep 60
done
