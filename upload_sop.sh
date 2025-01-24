#!/bin/bash

# Ensure required environment variables are set
if [[ -z "$QUALER_EMAIL" || -z "$QUALER_PASSWORD" || -z "$SOP_ID" || -z "$MERGED_FILE" ]]; then
    echo "Missing required environment variables. Exiting..."
    exit 1
fi

echo "Using SOP ID: $SOP_ID"
echo "Uploading File: $MERGED_FILE"

# Step 1: Get the login page to set cookies
curl -s -c cookies.txt 'https://jgiquality.qualer.com/login' -o /dev/null

# Step 2: Extract CSRF token from cookies
csrf_token_name=$(awk '$6 ~ /^__RequestVerificationToken_/ {print $6}' cookies.txt | head -1)
csrf_token_value=$(awk -v token="$csrf_token_name" '$6 == token {print $NF}' cookies.txt)

if [[ -z "$csrf_token_name" || -z "$csrf_token_value" ]]; then
  echo "Failed to extract CSRF token from cookies."
  exit 2
fi

echo "Extracted CSRF Token Name: $csrf_token_name"
echo "Extracted CSRF Token Value: [HIDDEN]"

# Step 3: Authenticate
status_code=$(curl -s -o login_response.html -w "%{http_code}" 'https://jgiquality.qualer.com/login?returnUrl=%2FSop%2FSops_Read' \
    -b cookies.txt -c cookies.txt \
    -X POST \
    -H 'Content-Type: application/x-www-form-urlencoded' \
    --data-raw "Email=$QUALER_EMAIL&Password=$QUALER_PASSWORD&$csrf_token_name=$csrf_token_value")

if [[ $status_code -ne 302 ]]; then
  echo "Authentication failed with status code $status_code"
  exit 3
fi

echo "Authentication successful"

# Step 4: Retrieve latest CSRF token from the SOP page
status_code=$(curl -s -w "%{http_code}" "https://jgiquality.qualer.com/Sop/Sop?sopId=$SOP_ID" \
    -X GET \
    -b cookies.txt -c cookies.txt -o sop_page.html)

if [[ $status_code -ne 200 ]]; then
    echo "Failed to fetch CSRF token from SOP page"
    exit 4
fi

csrf_token_value=$(grep -oP '(?<=<input name="__RequestVerificationToken" type="hidden" value=")[^"]*' sop_page.html)

if [[ -z "$csrf_token_value" ]]; then
    echo "Failed to extract updated CSRF token."
    exit 5
fi

echo "Updated CSRF Token extracted"

# Step 5: Upload the Excel file
status_code=$(curl -s -w "%{http_code}" -o upload_response.json "https://jgiquality.qualer.com/Sop/SaveSopFile" \
    -X POST \
    -b cookies.txt -c cookies.txt \
    -H "X-CSRF-Token: $csrf_token_value" \
    -F "Documents=@$MERGED_FILE" \
    -F "sopId=$SOP_ID" \
    -F "__RequestVerificationToken=$csrf_token_value")

if [[ $status_code -ne 200 ]]; then
    echo "Failed to upload the SOP file (status code: $status_code)"
    exit 6
fi

success=$(jq -r '.Success' upload_response.json)

if [[ "$success" == "true" ]]; then
    echo "✅ Upload succeeded!"
else
    echo "❌ Upload failed!"
    cat upload_response.json
    exit 7
fi
