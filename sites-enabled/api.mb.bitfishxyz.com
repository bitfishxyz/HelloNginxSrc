server {
  server_name api.mb.bitfish.xyz;
  location / {
   proxy_pass http://127.0.0.1:8081;
  }

    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/api.mb.bitfish.xyz/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/api.mb.bitfish.xyz/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

}
server {
    if ($host = api.mb.bitfish.xyz) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


  listen 80;
  server_name api.mb.bitfish.xyz;
    return 404; # managed by Certbot


}