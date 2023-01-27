#!/bin/bash

apt update -y && apt upgrade -y

wget -qO- https://github.com/containerd/containerd/releases/download/v1.6.15/containerd-1.6.15-linux-amd64.tar.gz | tar Cxzv /usr/local/

mkdir -p /usr/local/lib/systemd/system
wget -q https://raw.githubusercontent.com/containerd/containerd/main/containerd.service -P /usr/local/lib/systemd/system/

systemctl daemon-reload

wget -q https://github.com/opencontainers/runc/releases/download/v1.1.4/runc.amd64
install -m 755 runc.amd64 /usr/local/sbin/runc
rm runc.amd64

mkdir -p /opt/cni/bin
wget -qO- wget https://github.com/containernetworking/plugins/releases/download/v1.1.1/cni-plugins-linux-amd64-v1.1.1.tgz | tar Cxzv /opt/cni/bin/

mkdir -p /etc/containerd/
containerd config default > /etc/containerd/config.toml
sed -i 's/SystemdCgroup = false/SystemdCgroup = true/g' /etc/containerd/config.toml

systemctl enable --now containerd

apt install -y apt-transport-https ca-certificates curl
curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list
apt update -y
apt install -y kubelet kubeadm kubectl
echo "br_netfilter" | tee -a /etc/modules
modprobe br_netfilter
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
echo '1' > /proc/sys/net/ipv4/ip_forward

hostnamectl set-hostname $(curl -s http://169.254.169.254/latest/meta-data/local-hostname)

mkdir -p /data/volumes/pv1
chmod 777 /data/volumes/pv1