server {
	root /var/www/maleldil.com/html;
	index index.html;

	server_name maleldil.com;

	location / {
		try_files $uri $uri.html $uri/ $uri.html =404;
	}

	location = /favicon.ico {
		log_not_found off;
		access_log off;
	}

	listen [::]:443 ssl ipv6only=on; # managed by Certbot
	listen 443 ssl; # managed by Certbot
	ssl_certificate /etc/letsencrypt/live/maleldil.com/fullchain.pem; # managed by Certbot
	ssl_certificate_key /etc/letsencrypt/live/maleldil.com/privkey.pem; # managed by Certbot
	include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
	ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}

server {
	if ($host = maleldil.com) {
		return 301 https://$host$request_uri;
	} # managed by Certbot


	listen 80;
	listen [::]:80;

	server_name maleldil.com;
	return 404; # managed by Certbot
}
