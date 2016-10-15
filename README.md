# conjur-registry-proxy
Use conjur-asset-proxy to access a Conjur-protected Docker registry.

# Build

```
$ docker build -t conjur-registry-proxy .
```

# Run
You must first use `conjur init` and `conjur authn login` to connect to and authenticate with the Conjur server protecting the registry. Then, grab the path to the cert from `~/.conjurrc`, and start the proxy container in the background

```
$ cert_file=$(grep cert_file ~/.conjurrc | awk '{print $2}' | tr -d '"')
$ docker run -d -p 80:80 \
  -v ~/.netrc:/root/.netrc \
  -v ~/.conjurrc:/root/.conjurrc \
  -v $cert_file:/root/conjur.pem \
  -e CONJUR_CERT_FILE=/root/conjur.pem \
  --name conjur-registry-proxy conjur-registry-proxy
```

To see the logs:

```
$ docker logs conjur-registry-proxy
```

# Use

Run as above, the proxy listens on port 80 for requests to forward. If you reference your Docker registry by name (e.g. `registry.tld`), you'll need to add an entry to `/etc/hosts`:

```
127.0.0.1	registry.tld
```

Then, you can access your registry through the proxy

```
$ docker search registry.tld/conjur-appliance
NAME                                      DESCRIPTION   STARS     OFFICIAL   AUTOMATED
library/conjur-appliance                                0
```
