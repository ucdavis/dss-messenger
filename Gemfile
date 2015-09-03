source 'https://rubygems.org'

gem 'rails', '~> 4.2.3'

gem 'rubycas-client'
gem 'rake'
gem 'delayed_job_active_record'
gem 'daemons'
gem 'unicorn'
gem 'mail'
gem 'whenever'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

gem 'spring', group: :development
gem 'web-console', '~> 2.0', group: :development

gem 'turbolinks'

gem 'declarative_authorization'

# For automatic inline CSS for mailer
gem 'hpricot'
gem 'premailer-rails'

# For deployment
group :development do
  gem 'capistrano', '~> 3.1', require: false
  gem 'capistrano-rails',   '~> 1.1', require: false
  gem 'capistrano-bundler', '~> 1.1', require: false
  gem 'capistrano-passenger', require: false
  # gem 'capistrano-npm', require: false
  # We use our fork of capistrano3-delayed-job due to a bug in 'daemons' where delayed_job
  # will not stop correctly if not passed the number of workers in the 'stop' command
  gem 'capistrano3-delayed-job', git: 'git@github.com:cthielen/capistrano3-delayed-job.git'
end

# For debugging
gem 'byebug', group: [:development, :test]

# For JS-accessible routes
gem "js-routes"

gem 'jbuilder'

group :test, :development do
  gem 'sqlite3'
end

group :production do
  gem "pg"
end

gem 'jquery-rails'

# For Bootstrap support
gem 'bootstrap-sass', '~> 3.3.5'
gem 'sass-rails', '>= 3.2'

gem 'exception_notification'

# For loading remote JSON
gem 'rest-client'
