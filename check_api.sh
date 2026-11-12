#!/bin/bash

if [ "$#" -eq 0 ]; then
echo "URL не указан"
exit 1
fi

url="$1"
code=$(curl -s -o /dev/null -w "%{http_code}" "$url")
curl_result=$?

if [ "$curl_result" -ne 0 ]; then
echo "API недоступен, код ответа: $code"
exit 1
fi

echo "Код ответа: $code"
if [ "$code" = "200"  ]; then
echo "API доступен"
exit 0

else
echo "API недоступен, код ответа $code"
exit 1

fi
