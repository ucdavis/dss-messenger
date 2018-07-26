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

# Set Rails to run in production
ENV RAILS_ENV production
ENV RACK_ENV production

RUN bundle exec rake assets:precompile

EXPOSE 3000

# Start supervisor
CMD ["/usr/bin/supervisord", "-c", "./supervisord.conf"]
