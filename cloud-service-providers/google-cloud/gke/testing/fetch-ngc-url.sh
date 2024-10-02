#!/bin/sh
if ! which curl > /dev/null; then
  CURL_VERSION=8.10.1
  wget "https://github.com/stunnel/static-curl/releases/download/${CURL_VERSION}/curl-linux-x86_64-${CURL_VERSION}.tar.xz"
  tar xf "curl-linux-x86_64-${CURL_VERSION}.tar.xz"
  alias curl="$PWD/curl"
fi


echo "listing service accounts"
curl -X GET -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/"

echo ""
echo ""

echo "listing the project service account"


curl -X GET -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/ sa-nim-inframgr@isv-coe-skhas-nvidia.iam.gserviceaccount.com/"

echo ""
echo ""

echo "listing the default service account"
curl -X GET -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/"

echo ""
echo ""

echo "grabbing an id token"
ID_TOKEN=$(curl -X GET -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/identity?audience=http://www.example.com&format=full")

echo $ID_TOKEN
echo ""
echo ""


