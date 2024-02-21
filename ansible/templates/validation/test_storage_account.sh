# claimsuatstsa1kfq.privatelink.blob.core.windows.net
# claimsuatstsa1kfq.blob.core.windows.net



#!/bin/bash
storage_account=$AZ_STG_ACCOUNT
container_name=$AZ_STG_CONTAINER
access_key=$AZ_STG_ACCESS_KEY
blob_name=PSCR_230113_000000Fri.xml


storage_account="claimsuatstsa1kfq"
container_name="test"
access_key="vH9YaZKrCzbH5YjSbA7gLSMPj8Ui7ubup/IUM2vOj47geWXUdyWfvtNHaOeZvZh1PULyHlstJ8hD+AStNUMLMw=="
blob_name=file1.jpeg


blob_store_url="blob.core.windows.net"
authorization="SharedKey"

request_method="GET"
request_date=$(TZ=GMT date "+%a, %d %h %Y %H:%M:%S %Z")
storage_service_version="2015-02-21"

# HTTP Request headers
x_ms_date_h="x-ms-date:$request_date"
x_ms_version_h="x-ms-version:$storage_service_version"

# Build the signature string
canonicalized_headers="${x_ms_date_h}\n${x_ms_version_h}"
canonicalized_resource="/${storage_account}/${container_name}/${blob_name}"

string_to_sign="${request_method}\n\n\n\n\n\n\n\n\n\n\n\n${canonicalized_headers}\n${canonicalized_resource}"

# Decode the Base64 encoded access key, convert to Hex.
decoded_hex_key="$(printf $access_key | base64 -d -w0 | xxd -p -c256)"

# Create the HMAC signature for the Authorization header
signature=$(printf "$string_to_sign" | openssl dgst -sha256 -mac HMAC -macopt "hexkey:$decoded_hex_key" -binary |  base64 -w0)

authorization_header="Authorization: $authorization $storage_account:$signature"
# -v or --trace to enable tracing
curl -v \
  -H "$x_ms_date_h" \
  -H "$x_ms_version_h" \
  -H "$authorization_header" \
  "https://${storage_account}.${blob_store_url}/${container_name}/${blob_name}" -o ${blob_name}



# using SAS

# Synatax
# curl -i -X <HTTP Verb> -H "x-ms-version: 2019-12-12" "https://storageAccountName.blob.core.windows.net/containername/blobname?SASToken"

# Example
# curl -i -H "x-ms-version: 2019-12-12" "https://claimsuatstsa1kfq.blob.core.windows.net/test/file1.jpeg?sv=2022-11-02&ss=bfqt&srt=sco&sp=rwdlacupiytfx&se=2024-02-15T12:10:04Z&st=2024-02-15T04:10:04Z&spr=https&sig=5n%2F3ZqdQ0dxMkm%2FJu3Dc2Sx%2BiO%2F0HybQw%2F1Uo%2B%2FwJUo%3D"
# curl -i -H "x-ms-version: 2019-12-12" "https://claimsuatstsa1kfq.blob.core.windows.net/test/file1.jpg?sp=r&st=2024-02-15T04:23:17Z&se=2024-02-15T12:23:17Z&spr=https&sv=2022-11-02&sr=b&sig=NBo6TI0ICfkUV5PLrbWBlb53%2F09FEV3GVU5ga7hcvIk%3D"

# curl -i -H "x-ms-version: 2019-12-12" "https://claimsuatstsa1kfq.privatelink.blob.core.windows.net/test/file1.jpg?sp=r&st=2024-02-15T04:23:17Z&se=2024-02-15T12:23:17Z&spr=https&sv=2022-11-02&sr=b&sig=NBo6TI0ICfkUV5PLrbWBlb53%2F09FEV3GVU5ga7hcvIk%3D"

