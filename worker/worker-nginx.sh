wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1xn03kTB27K872cokqwEIlk8Zb121HnfB' -O lb

unzip lb

mv worker mylta.it05.com
mv mylta.it05.com /var/www/html/

rm -rf __MACOSX lb

service php7.0-fpm start

echo 'server {
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
}' > /etc/nginx/sites-available/default

service nginx restart

nginx -t