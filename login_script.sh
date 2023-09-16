#!/bin/bash

base_url="http://laravel-passport-api-shell-curl-access.test"
client_id="3"
client_secret="AU43oYLwMrBVMuaxxhG636yMqsJytSaYVrIcikjU"

access_token=$(curl -s -X POST -H "Accept: application/json" \
  -d "grant_type=password" \
  -d "client_id=$client_id" \
  -d "client_secret=$client_secret" \
  -d "username=john@example.com" \
  -d "password=secret" \
  "$base_url/oauth/token" | jq -r '.access_token')

user_info=$(curl -s -X GET -H "Accept: application/json" \
  -H "Authorization: Bearer $access_token" \
  "$base_url/api/user")

username=$(echo "$user_info" | jq -r '.name')
email=$(echo "$user_info" | jq -r '.email')

echo "Username: $username"
echo "Email: $email"
