#!/bin/bash -ex

if ! [[ "$(conjur authn whoami 2>/dev/null)" =~ account ]] ; then
  conjur authn login
fi

bundle exec conjur proxy -a 127.0.0.1 -p 80 https://docker-registry.itci.conjur.net/
