upstream _enpit2015 {
    server unix:/var/run/uwsgi/enpit2015.sock;
}

server {
    listen 80;
    server_name enpit2015.com;
    charset     utf-8;
    root /vagrant/development/WEB/application/var/www/app/;

    location / {
        try_files $uri @uwsgi;
    }

    location @uwsgi {
        include uwsgi_params;
        uwsgi_pass _enpit2015;
    }
}