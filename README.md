# conjur-registry-proxy
Use conjur-asset-proxy to access a Conjur-protected Docker registry.

# Run
You must first use `conjur init` to connect to the Conjur server protecting the registry.

```
$ ./run.sh
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
