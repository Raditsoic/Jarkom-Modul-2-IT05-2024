echo 'upstream backend_servers {
  server 10.66.1.2:8002; 
  server 10.66.1.3:8002; 
  server 10.66.1.4:8002; 
}

server {
  listen 80;
  server_name severny.com www.severny.com;

  location / {
    proxy_pass http://backend_servers;
    proxy_set_header host $host;
    proxy_set_header X-Real_IP $remote_addr;
    proxy_set_header X-Real_IP $proxy_add_x_forwarded_for;
  }

  location ~ /\.ht {
        deny all;
    }
}
' > /etc/nginx/sites-available/default

service nginx restart