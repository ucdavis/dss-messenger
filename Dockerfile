FROM ruby:2.3

# Update and install stuff your app needs to run
RUN apt-get update -qq && \
	apt-get install -yq nodejs supervisor

# Installing your gems this way caches this step so you dont have to reintall your gems every time you rebuild your image.
# More info on this here: http://ilikestuffblog.com/2014/01/06/how-to-skip-bundle-install-when-deploying-a-rails-app-to-docker/
# Copy the Gemfile and Gemfile.lock into the image.
WORKDIR /usr/src/app/
COPY ["Gemfile", "Gemfile.lock", "./"]

RUN gem install bundler
RUN bundle install

RUN mkdir -p /usr/src/app/log

RUN ln -sf /dev/stdout /usr/src/app/log/delayed_rake.log

# Copy our source files precompile assets
COPY . ./

# Environment variables
ARG SECRET_KEY_BASE
ENV SECRET_KEY_BASE $SECRET_KEY_BASE
ARG CAS_URL
ENV CAS_URL $CAS_URL

RUN bundle exec rake assets:precompile

EXPOSE 3000

# Start supervisor
CMD ["/usr/bin/supervisord", "-c", "./supervisord.conf"]
