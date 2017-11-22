FROM ruby:2.3

# Update and install stuff your app needs to run
RUN apt-get update -qq && \
	apt-get install -yq nodejs nginx supervisor && \
	rm -rf /etc/nginx/sites-available/default

# Installing your gems this way caches this step so you dont have to reintall your gems every time you rebuild your image.
# More info on this here: http://ilikestuffblog.com/2014/01/06/how-to-skip-bundle-install-when-deploying-a-rails-app-to-docker/
# Copy the Gemfile and Gemfile.lock into the image.
WORKDIR /usr/src/app/
COPY ["Gemfile", "Gemfile.lock", "./"]

RUN gem install bundler
RUN bundle install

RUN mkdir -p /usr/src/app/log
RUN mkdir -p /var/log/nginx

RUN ln -sf /dev/stdout /usr/src/app/log/production.log
RUN ln -sf /dev/stdout /usr/src/app/log/development.log
RUN ln -sf /dev/stdout /usr/src/app/log/test.log
RUN ln -sf /dev/stdout /usr/src/app/log/delayed_rake.log
RUN ln -sf /dev/stdout /usr/src/app/log/unicorn.stdout.log
RUN ln -sf /dev/stdout /var/log/nginx/access.log

RUN ln -sf /dev/stderr /usr/src/app/unicorn.stderr.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

# Configure nginx
COPY ./nginx.conf /etc/nginx/nginx.conf

# Copy our source files precompile assets
COPY . ./
RUN chown -R www-data:www-data .
RUN bundle exec rake assets:precompile

EXPOSE 443

# Start supervisor
CMD ["/usr/bin/supervisord", "-c", "./supervisord.conf"]
