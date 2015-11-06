server {
    listen 80;
    server_name localhost;
    charset     utf-8;
    access_log   /vagrant/development/WEB/application/var/www/app/enpit2015.access.log;

    location / {
        try_files $uri @uwsgi;
    }

    location /static/ {
        root /vagrant/development/WEB/application/var/www/app;
    }

    location @uwsgi {
        include uwsgi_params;
        uwsgi_pass unix:/var/uwsgi/sockets/enpit2015.sock;
    }
}