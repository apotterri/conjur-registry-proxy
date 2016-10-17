#!/bin/bash

DOCKER_ARGUMENTS="-d"

while [[ $# -gt 0 ]]
do
key="$1"

case $key in
  -i|--interactive)
    DOCKER_ARGUMENTS="-it"
    shift
  ;;
  -h|--help)
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Run a local proxy for private Docker repository access."
    echo ""
    echo "Options:"
    echo ""
    echo "-h, --help          Show help"
    echo "-i, --interactive   Run in interactive mode"
    echo ""
    shift
  ;;
  *)
    echo "$key isn't a valid argument. Run ./run.sh --help to view the help file."
    shift
  ;;

esac
done

if ! [[ "$(conjur authn whoami)" =~ account ]] ; then
  conjur authn login
fi

docker build -t conjur-registry-proxy .

cert_file=$(grep cert_file ~/.conjurrc | awk '{print $2}' | tr -d '"')

PROXY_DOCKER_ID=$(docker ps -a -f name=conjur-registry-proxy -q)
if [[ $PROXY_DOCKER_ID ]] ; then
  docker stop $PROXY_DOCKER_ID
  docker rm $PROXY_DOCKER_ID
fi

docker run $DOCKER_ARGUMENTS -p 80:80 \
    -v ~/.netrc:/root/.netrc \
    -v ~/.conjurrc:/root/.conjurrc \
    -v $cert_file:/root/conjur.pem \
    -e CONJUR_CERT_FILE=/root/conjur.pem \
    --name conjur-registry-proxy conjur-registry-proxy

if [[ $DOCKER_ARGUMENTS = "-d" ]] ; then
  echo ""
  echo "Your Docker proxy is ready to be used!"
fi
