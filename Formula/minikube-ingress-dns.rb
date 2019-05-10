class MinikubeIngressDns < Formula
  desc "Configure and restart dnsmasq automatically for Kubernetes Ingress LB on minikube"
  homepage "https://github.com/ghimire/minikube-ingress-dns"
  head "https://github.com/ghimire/minikube-ingress-dns.git", branch: "master"

  def install
    (prefix/"etc/minikube-ingress-dns").install %w(
      minikube-ingress-dns
      common.sh
      clean.sh
    )
  end

  def caveats; <<~EOS
    Add the following line to your ~/.bash_profile:
    alias minikube=#{etc}/minikube-ingress-dns/minikube-ingress-dns
    EOS
  end
end
