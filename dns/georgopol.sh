echo 'zone "pochinki.com" {
    type slave;
    masters { 10.66.3.2; };
    file "/var/lib/bind/pochinki.com";
};' > /etc/bind/named.conf.local

echo 'zone "airdrop.it05.com" {
    type slave;
    masters { 10.66.3.2; };
    file "/var/lib/bind/airdrop.it05.com";
};' >> /etc/bind/named.conf.local

echo 'zone "redzone.it05.com" {
    type slave;
    masters { 10.66.3.2; };
    file "/var/lib/bind/redzone.it05.com";
};' >> /etc/bind/named.conf.local

echo 'zone "loot.it05.com" {
    type slave;
    masters { 10.66.3.2; };
    file "/var/lib/bind/loot.it05.com";
};' >> /etc/bind/named.conf.local

echo 'zone "siren.redzone.it05.com" {
   type master;
   file "/etc/bind/delegasi/siren.redzone.it05.com";
};' >> /etc/bind/named.conf.local

echo ';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     siren.redzone.it05.com. root.siren.redzone.it05.com. (
                     2022100601         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      siren.redzone.it05.com.
@       IN      A       10.66.1.2
www     IN      A       10.66.1.2
log     IN      A       10.66.1.2
www.log IN      CNAME   www.siren.redzone.it05.com.' > /etc/bind/delegasi/siren.redzone.it05.com

service bind9 restart