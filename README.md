# conjur-registry-proxy

Use conjur-asset-proxy to access a Conjur-protected Docker registry.

# Configuration

## `/etc/hosts`

For historical reasons, the name of Conjur's Docker registry is `registry.tld`. Add this name as an alias to localhost in your `/etc/hosts` file (for example, by running `sudo nano /etc/hosts`; use `Ctrl-O` to save, `Ctrl-X` to exit). It should look something like this when you are done:

```sh-session
$ cat /etc/hosts
##
# Host Database
#
# localhost is used to configure the loopback interface
# when the system is booting.  Do not change this entry.
##
127.0.0.1	localhost
127.0.0.1       registry.tld
255.255.255.255	broadcasthost
::1             localhost
fe80::1%lo0	localhost
```

## Docker for Mac

Next, add `registry.tld` as an "insecure registry" to your Docker for Mac configuration:

![Add registry.tld as an insecure registry](./doc/images/docker_mac_config.png)

Note: This does not actually make the registry insecure, because all the "insecure" (non-HTTPS) traffic is happening inside your local machine.

# Run

```
$ ./run.sh
```

# Use

Run as above, the proxy listens on localhost port 80 for requests to forward. Then, you can access your registry through the proxy

```
$ docker search registry.tld/conjur-appliance
NAME                                      DESCRIPTION   STARS     OFFICIAL   AUTOMATED
library/conjur-appliance                                0
```
