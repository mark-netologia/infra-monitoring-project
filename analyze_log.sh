#!/bin/bash

> access.log

ips=("192.168.1.10" "10.0.0.5" "172.16.0.8" "192.168.1.25" "10.0.0.20")
statuses=(200 201 400 404 500 503)

for i in {1..300}; do
    ip=${ips[$RANDOM % 5]}
    status=${statuses[$RANDOM % 6]}

    echo "$ip - - [15/Aug/2026:10:15:32] \"GET /api/users HTTP/1.1\" $status" >> access.log
done

counter=$(wc -l < access.log)
echo "Общее количество записей в файле access.log: $counter"

echo "Топ-3 IP по популярности:"
awk '{print $1}' access.log | sort | uniq -c | sort -nr | head -n 3

err4xx=$(grep -Ec ' 4[0-9]{2}$' access.log)
err5xx=$(grep -Ec ' 5[0-9]{2}$' access.log)

echo "Ошибок 4хх: $err4xx"
echo "Ошибок 5хх: $err5xx"
