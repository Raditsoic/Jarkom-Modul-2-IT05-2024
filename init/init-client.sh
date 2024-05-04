#nano /root/.bashrc
echo 'nameserver 10.66.3.2
nameserver 10.66.4.2
nameserver 192.168.122.1' > /etc/resolv.conf

apt-get update
apt-get install dnsutils -y
apt-get install lynx -y