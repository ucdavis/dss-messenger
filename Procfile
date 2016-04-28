app: unicorn -c config/unicorn.rb
nginx: /usr/sbin/nginx -g 'daemon off;'
worker: /usr/src/app/bin/delayed_job start -n 5 -- -t