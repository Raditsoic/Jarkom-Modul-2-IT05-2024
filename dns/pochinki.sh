echo 'zone "pochinki.com" {
    type master;
    also-notify { 10.66.4.2; };
    allow-transfer { 10.66.4.2; };
    file "/etc/bind/jarkom/pochinki.com";
};' > /etc/bind/named.conf.local

echo 'zone "airdrop.it05.com" {
    type master;
    also-notify { 10.66.4.2; };
    allow-transfer { 10.66.4.2; };
    file "/etc/bind/jarkom/airdrop.it05.com";
};' >> /etc/bind/named.conf.local

echo 'zone "redzone.it05.com" {
    type master;
    also-notify { 10.66.4.2; };
    allow-transfer { 10.66.4.2; };
    file "/etc/bind/jarkom/redzone.it05.com";
};' >> /etc/bind/named.conf.local

echo 'zone "loot.it05.com" {
    type master;
    also-notify { 10.66.4.2; };
    allow-transfer { 10.66.4.2; };
    file "/etc/bind/jarkom/loot.it05.com";
};' >> /etc/bind/named.conf.local

mkdir /etc/bind/jarkom

cp /etc/bind/db.local /etc/bind/jarkom/pochinki.com

echo ';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     pochinki.com. root.pochinki.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      pochinki.com.
@       IN      A       10.66.3.2
@       IN      AAAA    ::1' > /etc/bind/jarkom/pochinki.com

cp /etc/bind/db.local /etc/bind/jarkom/airdrop.it05.com

echo ';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     airdrop.it05.com. root.airdrop.it05.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      airdrop.it05.com.
@       IN      A       10.66.1.4
www     IN      CNAME   airdrop.it05.com.
medkit  IN      A       10.66.4.2
@       IN      AAAA    ::1' > /etc/bind/jarkom/airdrop.it05.com

cp /etc/bind/db.local /etc/bind/jarkom/redzone.it05.com

echo ';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     redzone.it05.com. root.redzone.it05.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      redzone.it05.com.
@       IN      A       10.66.1.2
www     IN      CNAME   redzone.it05.com.
ns1     IN      A       10.66.4.2
siren   IN      NS      ns1
@       IN      AAAA    ::1' > /etc/bind/jarkom/redzone.it05.com

cp /etc/bind/db.local /etc/bind/jarkom/loot.it05.com

echo ';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     loot.it05.com. root.loot.it05.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      loot.it05.com.
@       IN      A       10.66.1.5
www     IN      CNAME   loot.it05.com.
@       IN      AAAA    ::1' > /etc/bind/jarkom/loot.it05.com

#Nomor 6
echo 'zone "1.66.10.in-addr.arpa" {
    type master;
    file "/etc/bind/jarkom/1.66.10.in-addr.arpa";
};' >> /etc/bind/named.conf.local

cp /etc/bind/db.local /etc/bind/jarkom/1.66.10.in-addr.arpa

echo ';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     redzone.it05.com. root.redzone.it05.com. (
                     2022100601         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
1.66.10.in-addr.arpa.       IN      NS      redzone.it05.com.
2                           IN      PTR     redzone.it05.com' > /etc/bind/jarkom/1.66.10.in-addr.arpa

service bind9 restart
