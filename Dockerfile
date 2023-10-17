FROM ruby:3.1

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

# Environment variables
ARG SECRET_KEY_BASE
ENV SECRET_KEY_BASE $SECRET_KEY_BASE
ARG CAS_URL=something.cas
ENV CAS_URL $CAS_URL
ARG ROLES_HOST
ENV ROLES_HOST $ROLES_HOST
ARG ROLES_USER
ENV ROLES_USER $ROLES_USER
ARG ROLES_PASSWORD
ENV ROLES_PASSWORD $ROLES_PASSWORD
ARG HOST
ENV HOST $HOST
ARG DYNAMODB_REGION
ENV DYNAMODB_REGION $DYNAMODB_REGION
ARG DYNAMODB_MESSAGE_RECEIPT_TABLE
ENV DYNAMODB_MESSAGE_RECEIPT_TABLE $DYNAMODB_MESSAGE_RECEIPT_TABLE
ARG DYNAMODB_AWS_ACCESS_KEY
ENV DYNAMODB_AWS_ACCESS_KEY $DYNAMODB_AWS_ACCESS_KEY
ARG DYNAMODB_AWS_SECRET_KEY
ENV DYNAMODB_AWS_SECRET_KEY $DYNAMODB_AWS_SECRET_KEY
ARG DB_HOST
ENV DB_HOST $DB_HOST
ARG DB_PORT
ENV DB_PORT $DB_PORT
ARG DB_USERNAME
ENV DB_USERNAME $DB_USERNAME
ARG DB_PASSWORD
ENV DB_PASSWORD $DB_PASSWORD
ARG DB_SCHEMA
ENV DB_SCHEMA $DB_SCHEMA
ARG RAILS_ENV
ENV RAILS_ENV $RAILS_ENV
ARG RACK_ENV
ENV RACK_ENV $RACK_ENV

# Use Rails for static files in public
ENV RAILS_SERVE_STATIC_FILES 0

# Set Rack::Timeout values
ENV RACK_TIMEOUT_SERVICE_TIMEOUT 120

# Log to STDOUT
ENV RAILS_LOG_TO_STDOUT 1

# Ensure delayed_job logs go to STDOUT
RUN ln -sf /proc/1/fd/1 /usr/src/app/log/delayed_rake.log
RUN ln -sf /proc/1/fd/1 /usr/src/app/log/delayed_job.log
 
# Copy our source files precompile assets
COPY . ./

RUN bundle exec rake assets:precompile

EXPOSE 3000

# create directory needed for puma pid file
RUN mkdir -p tmp/pids

# Start supervisor
CMD ["/usr/bin/supervisord", "-c", "./supervisord.conf"]
