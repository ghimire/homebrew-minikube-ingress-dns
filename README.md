# minikube-ingress-dns for macOS

This repository contains the script files in order to configure and restart dnsmasq automatically for Kubernetes Ingress Controller on minikube after running `minikube start`. This allows wildcard domain (eg `*.k8s.local`) to be used during development without having to add inidividual domains to `/etc/hosts`.

## Installation

You can install minikube-ingress-dns with homebrew as follows:

```
$ brew tap ghimire/minikube-ingress-dns
$ brew install minikube-ingress-dns
```

## Requirement

To work minikube-ingress-dns requires dnsmasq. You can install dnsmasq by using Homebrew.

```
$ brew install dnsmasq
$ brew services start dnsmasq
```

## Usage

To start the script every time `minikube start` is issued, dd the following to `~/.bash_profile`:
```sh
alias minikube=$(brew --prefix)/etc/homebrew-minikube-ingress-dns/minikube-ingress-dns
```

The default base domain for Ingress LB is `k8s.local`. For example, if you create an ingress object like the following, you can access http://nginx.k8s.local/ directly with curl, browser or something.

```
$ minikube start
$ minikube addons enable ingress
$ kubectl run nginx --image=nginx
$ kubectl expose deploy nginx --port=80 --target-port=80
$ cat <<EOL | kubectl apply -f -
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: nginx.k8s.local
spec:
  rules:
  - host: nginx.k8s.local
    http:
      paths:
      - backend:
          serviceName: nginx
          servicePort: 80
EOL
$ curl http://nginx.k8s.local/
```

If you'd like to change the base domain from `k8s.local`, set the new domain name to the `MINIKUBE_INGRESS_DNS_DOMAIN` environment variable.

```sh
export MINIKUBE_INGRESS_DNS_DOMAIN="kube.test"
```

## Cleaning Up
If installed with Homebrew,
```
$ cd $(brew --prefix minikube-ingress-dns)/etc/minikube-ingress-dns
```

Run cleanup and uninstall:
```
$ bash cleanup.sh
$ brew uninstall minikube-ingress-dns
```

Optionally, uninstall `dnsmasq`:
```
$ brew services stop dnsmasq
$ brew uninstall dnsmasq
```

## License

These scripts are released under the MIT License.
