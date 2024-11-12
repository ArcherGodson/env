#!/usr/bin/env bash

AUTH_KEY="$(cat ~/tools/gigachat.key)"
REQUEST="curl -s -k -L -X POST 'https://ngw.devices.sberbank.ru:9443/api/v2/oauth' \
-H 'Content-Type: application/x-www-form-urlencoded' \
-H 'Accept: application/json' \
-H 'RqUID: $(uuidgen)' \
-H 'Authorization: Basic $AUTH_KEY' \
--data-urlencode 'scope=GIGACHAT_API_PERS'"
API_KEY=$(eval $REQUEST | jq -r '[.access_token][0]')

gigachat() {
  REQUEST="curl -s -k -L -X GET 'https://gigachat.devices.sberbank.ru/api/v1/balance' \
-H 'Accept: application/json' \
-H 'Authorization: Bearer ${API_KEY}' \
"
  response=$(eval $REQUEST)
  result=$(echo "$response" | jq -r '.balance[] | select(.usage == "GigaChat") | .value')
  echo "Balance: ${result} tokens"
}

gigachat "$@"
