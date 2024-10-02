#!/bin/sh
if ! which curl > /dev/null; then
  CURL_VERSION=8.10.1
  wget "https://github.com/stunnel/static-curl/releases/download/${CURL_VERSION}/curl-linux-x86_64-${CURL_VERSION}.tar.xz"
  tar xf "curl-linux-x86_64-${CURL_VERSION}.tar.xz"
  alias curl="$PWD/curl"
fi


curl -X GET -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/"


ID_TOKEN=$(curl -X GET -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/identity?audience=http://www.example.com&format=full")

echo $ID_TOKEN

# use --token-format=full for print-identity-token if using GCE VM.
cat <<EOF > req.cred.json
{
  "bucket": "${NIM_GCS_BUCKET}",
  "text": "${NGC_EULA_TEXT}",
  "textb64": "$(echo ${NGC_EULA_TEXT} | base64 -w0)",
  "jwt": "$ID_TOKEN"
}
EOF
HTTP_URL="$(curl -s -X POST -H 'accept: application/json' -H 'Content-Type: application/json' -d @req.cred.json "https://${SERVICE_FQDN}/v1/request/${GCS_FILENAME}" | sed 's/.*\(https.*\)\\\\n.*/\1/g')"
echo -n "$HTTP_URL"

