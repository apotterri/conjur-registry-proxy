#!/bin/bash

conjur authn login

docker build -t conjur-registry-proxy .

if  ! ( docker ps | grep conjur-registry-proxy ) ; then
  cert_file=$(grep cert_file ~/.conjurrc | awk '{print $2}' | tr -d '"')
  docker run -d -p 80:80 \
    -v ~/.netrc:/root/.netrc \
    -v ~/.conjurrc:/root/.conjurrc \
    -v $cert_file:/root/conjur.pem \
    -e CONJUR_CERT_FILE=/root/conjur.pem \
    --name conjur-registry-proxy conjur-registry-proxy
fi

docker logs -f conjur-registry-proxy
