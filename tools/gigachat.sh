#!/usr/bin/env bash

# Замените 'YOUR_API_KEY' на ваш реальный API ключ
AUTH_KEY="$(cat ~/tools/gigachat.key)"
REQUEST="curl -s -k -L -X POST 'https://ngw.devices.sberbank.ru:9443/api/v2/oauth' \
-H 'Content-Type: application/x-www-form-urlencoded' \
-H 'Accept: application/json' \
-H 'RqUID: $(uuidgen)' \
-H 'Authorization: Basic $AUTH_KEY' \
--data-urlencode 'scope=GIGACHAT_API_PERS'"
API_KEY=$(eval $REQUEST | jq -r '[.access_token][0]')

gigachat() {
  if [ $# -eq 0 ]; then
    echo "Usage: ai \"Your message\"" >&2
    return 1
  fi
  REQUEST="curl -s -k -L -X POST 'https://gigachat.devices.sberbank.ru/api/v1/chat/completions' \
-H 'Content-Type: application/json' \
-H 'Accept: application/json' \
-H 'Authorization: Bearer ${API_KEY}' \
--data-raw '{ \
  \"model\": \"GigaChat\", \
  \"messages\": [ \
    { \
      \"role\": \"system\", \
      \"content\": \"Ты педантичный эксперт\" \
    }, \
    { \
      \"role\": \"user\", \
      \"content\": \"$@\" \
    } \
  ], \
  \"stream\": false, \
  \"update_interval\": 0 \
}' \
"
  response=$(eval $REQUEST)
#  echo "${REQUEST}"
#  echo "${response}"
  result=$(echo "$response" | jq -r '.choices[].message.content')
  echo "${result}"
}

gigachat "$@"
