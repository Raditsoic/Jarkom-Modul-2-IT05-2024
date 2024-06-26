<div align=center>

# Laporan Resmi Modul 2 Jaringan Komputer

</div>

## Anggota Kelompok

|Nama|NRP|
|--|--|
|Fazrul Ahmad Fadhillah|5027221025|
|Awang Fraditya|5027221055|


### Soal 1
- Untuk membuat DNS master pada node **pochinki**, buka file `/etc/bind/named.conf.local` dan tambahkan script ini:
```bash
zone "pochinki.com" {
    type master;
    also-notify { 10.66.4.2; };
    allow-transfer { 10.66.4.2; };
    file "/etc/bind/jarkom/pochinki.com";
};
```
Lalu pada file `etc/bind/jarkom/pochinki.com` ubah konfigurasinya menjadi:
```bash
;
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
@       IN      AAAA    ::1
```

- Selanjutnya kita akan membuat DNS slave pada node **Georgopool**. Buka file `/etc/bind/named.conf.local` di dalam node **Georgopool**, lalu tambahkan script berikut :
```bash
zone "pochinki.com" {
    type slave;
    masters { 10.66.3.2; };
    file "/var/lib/bind/pochinki.com";
};
```
ini akan membuat DNS slave yang mengarah ke **Pochinki**.

- Lalu kita akan membuat 3 web server pada **Severny**, **Stalber**, dan **Lipovka**. Kita juga akan membuat **Mylta** sebagai load balancer untuk ketiga web server tersebut. Tambahkan script ini ke ketiga node yang ingin kita jadikan web server:
```bash
server {
    listen 8002;
    root /var/www/html/mylta.it05.com/;
    index index.php index.html index.htm;

    server_name mylta.it05.com;

    location / {
        try_files $uri $uri/ /index.php$is_args$args;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
    }

    location ~ /\.ht {
        deny all;
    }
}'
```

### Soal 2

Pada file `/etc/bind/named.conf.local` di node **Pochinki** untuk menambahkan domain *airdrop.it05.com* kita bisa menambahkan script berikut untuk mengarah ke **Stalber** yang memiliki `ip 10.66.1.4`

```bash
zone "airdrop.it05.com" {
    type master;
    also-notify { 10.66.4.2; };
    allow-transfer { 10.66.4.2; };
    file "/etc/bind/jarkom/airdrop.it05.com";
};
```

Dan pada file `etc/bind/jarkom/airdrop.it05.com` tambahkan script berikut:

```bash
;
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
@       IN      AAAA    ::1
```

### Soal 3

Pada file `/etc/bind/named.conf.local` di node **Pochinki** untuk menambahkan domain *redzone.it05.com* kita bisa menambahkan script berikut untuk mengarah ke **Severny** yang memiliki ip `10.66.1.2`

```bash
zone "redzone.it05.com" {
    type master;
    also-notify { 10.66.4.2; };
    allow-transfer { 10.66.4.2; };
    file "/etc/bind/jarkom/redzone.it05.com";
};
```

Dan pada file `etc/bind/jarkom/redzone.it05.com` tambahkan script berikut:

```bash
;
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
@       IN      AAAA    ::1
```

## Soal 4

Pada file `/etc/bind/named.conf.local` di node **Pochinki** untuk menambahkan domain *loot.it05.com* kita bisa menambahkan script berikut untuk mengarah ke **Mylta** yang memiliki ip `10.66.1.5`

```bash
zone "loot.it05.com" {
    type master;
    also-notify { 10.66.4.2; };
    allow-transfer { 10.66.4.2; };
    file "/etc/bind/jarkom/loot.it05.com";
};
```

Dan pada file `etc/bind/jarkom/loot.it05.com` tambahkan script berikut:

```bash
;
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
@       IN      AAAA    ::1
```

### Soal 5
- pada **zharki** :


![zharki](<img/test_zharki.jpg>)

- pada **yasnaya** :


![yasnaya](<img/test_yasnaya.jpg>)

- pada **primorsk** :


![primorsk](<img/test_primorsk.jpg>)
### Soal 6

Untuk menambahkan pointer record pada domain **redzone.it05.com**. Pada `/etc/bind/named.conf.local` tambahkan:

```bash
zone "1.66.10.in-addr.arpa" {
    type master;
    file "/etc/bind/jarkom/1.66.10.in-addr.arpa";
};
```

Pada `/etc/bind/jarkom/1.66.10.in-addr.arpa` tambahkan:

```bash
;
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
2                           IN      PTR     redzone.it05.com
```

### Soal 7

Untuk mengarahkan semua domain ke DNS Slave maka diperlukan setup tambahan agar mengarah ke IP Georgopol `10.66.4.2` pada `/etc/bind/named.conf.local` dalam setiap zone domainnya seperti berikut:

```bash
also-notify { 10.66.4.2; };
allow-transfer { 10.66.4.2; };
```

Pada node Georgopol juga diperlukan setup DNS Slave pada `/etc/bind/named.conf.local` sebagai berikut untuk menghandle master yang mati:

```bash
one "pochinki.com" {
    type slave;
    masters { 10.66.3.2; };
    file "/var/lib/bind/pochinki.com";
};

one "airdrop.it05.com" {
    type slave;
    masters { 10.66.3.2; };
    file "/var/lib/bind/airdrop.it05.com";
};

zone "redzone.it05.com" {
    type slave;
    masters { 10.66.3.2; };
    file "/var/lib/bind/redzone.it05.com";
};

zone "loot.it05.com" {
    type slave;
    masters { 10.66.3.2; };
    file "/var/lib/bind/loot.it05.com";
};
```

### Soal 8

Untuk menambahkan subdomain kita bisa menambahkan setup A dengan nama *medkit* pada domain **airdrop.it05.com** seperti berikut:

```bash
medkit  IN      A       10.66.4.2
```

### Soal 9 

Untuk menambahkan subdomain *siren* dan alias *www* pada **redzone.it05.com** kita bisa menambahkan pada conf **redzone.it05.com** dan mengarahkan ke IP *Georgopool* seperti berikut:

```bash
ns1     IN      A       10.66.4.2
siren   IN      NS      ns1
```

Pada node *Pochinki* dan *Georgopool* kita juga perlu menambahkan code sebagai berikut pada `/etc/bind/named.conf.options`:

```bash
allow-query{any;};
```

Selain itu, kita juga perlu menambahkan comment pada `dnnsec-validation auto;`

Pada node Georgopol kita juga perlu setup domain *siren* dan aliasnya. Pada `/etc/bind/named.conf.local` tambahkan;

```bash
zone "siren.redzone.it05.com" {
   type master;
   file "/etc/bind/delegasi/siren.redzone.it05.com";
};
```

Dan pada `/etc/bind/delegasi/siren.redzone.it05.com` kita perlu mengarahkannya ke IP Severny `10.66.1.2` adalah seperti berikut:

```bash
;
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
```

### Soal 10

Untuk menambahkan `log` kita bisa menambahkan code berikut pada `/etc/bind/delegasi/siren.redzone.it05.com` seperti berikut:

```bash
log     IN      A       10.66.1.2
www.log IN      CNAME   www.siren.redzone.it05.com.
```

### Soal 11

Untuk konfigurasi agar warga *Erangel* yang berada diluar *Pochinki* dapat mengakses jaringan luar melalui DNS Server *Pochinki*, kita bisa menggunakan port forwarding IP `1192.168.122.1` dalam file `/etc/bind/named.conf.options` pada node *Pochinki* sebagai berikut:

```bash
forwarders {
    192.168.122.1;
};
```

### Soal 12
Untuk mendeploy website menggunakan apache, lakukan config pada file `/etc/apache2/sites-available/default`
```bash
server {
    listen 8002;
    root /var/www/html/mylta.it05.com/;
    index index.php index.html index.htm;

    server_name mylta.it05.com;
    server_alias www.mylta.it05.com

    location / {
        try_files $uri $uri/ /index.php$is_args$args;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
    }

    location ~ /\.ht {
        deny all;
    }
}
```
### Soal 13
Gunakan script ini untuk menggunakan apache sebagai web server dan load balancernya:
```bash
server {
    listen 8002;
    root /var/www/html/mylta.it05.com/;
    index index.php index.html index.htm;

    server_name parikesit.mylta.it05.com;
    server_alias www.parikesit.mylta.it05.com

    location / {
        try_files $uri $uri/ /index.php$is_args$args;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
    }

    location ~ /\.ht {
        deny all;
    }
}
```
### Soal 14

Kita bisa setup worker dalam web server nginx pada file `/etc/nginx/sites-available/default` **Severny**, **Stalber**, dan **Lipovka** dengan sebagai berikut:

```bash
server {
    listen 8002;
    root /var/www/html/mylta.it05.com/;
    index index.php index.html index.htm;

    server_name mylta.it05.com;

    location / {
        try_files $uri $uri/ /index.php$is_args$args;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
    }

    location ~ /\.ht {
        deny all;
    }
}

server {
    listen 8002;
    server_name www.mylta.it05.com;  

    root /var/www/html/www.mylta.it05.com/;  

}
```

lalu kita bisa menyalakan web-server nginx dengan `service nginx restart` atau `start`

Note: /var/www/html/mylta.it05.com/index.php adalah file yang akan di host oleh web server

### Soal 16
Buka file `/etc/bind/named.conf.local` pada node **Pochinki** dan tambahkan:
```bash
zone "mylta.it05.com" {
    type master;
    file "/etc/bind/jarkom/mylta.it05.com";
};
```
dan 
```bash
zone "1.66.10.in-addr.arpa" {
    type master;
    notify yes;
    also-notify { 10.66.4.2; };
    allow-transfer { 10.66.4.2; };
    file "/etc/bind/jarkom/1.66.10.in-addr.arpa";
};
```

lalu config pada file `/etc/bind/jarkom/mylta.it05.com`:
```bash
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     mylta.it05.com. root.mylta.it05.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@             IN      NS      mylta.it05.com.
@             IN      A       10.66.1.5 ; IP mylta
www           IN      CNAME   mylta.it05.com.
```

config pada file `1.66.10.in-addr.arpa`:
```bash
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     mylta.it05.com. root.mylta.it05.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
; PTR Records
1.66.10.in-addr.arpa.    IN      NS      mylta.it05.com.
2                        IN      PTR     www.mylta.it05.com.
```

### Soal 17
Pada nginx **mylta**, lakukan config:
```bash
upstream mylta {
    server 10.66.1.4:8002; 
    server 10.66.1.2:8002; 
    server 10.66.1.3:8002; 
}

server {
  listen 14000;
  listen 14400;
  server_name 10.66.1.5;

  location / {
    proxy_pass http://mylta;
  }
}
" > /etc/nginx/sites-available/default
```

### Soal 18
Untuk soal 18, pengerjaannya sudah dilakukan bersamaan dengan soal 16

