server {
        listen 80 default_server;
        listen [::]:80 default_server;

        listen 443 ssl;

        root {{root_path}};
        index index.php index.html index.htm;
        server_name localhost;

        location / {
                try_files $uri $uri/ /index.html;
        }

        error_page 404 /404.html;
        error_page 500 502 503 504 /50x.html;

        location = /50x.html {
                root /usr/share/nginx/www;
        }

        ssl_certificate {{cert_path}};
        ssl_certificate_key {{cert_key_path}};

        location ~ \.php$ {
                try_files $uri =404;
                fastcgi_pass unix:/var/run/php5-fpm.sock;
                fastcgi_index index.php;
                fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
                include fastcgi_params;
        }

}
