source 'https://rubygems.org'

gem 'rails', '~> 4.2.7'

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0', require: false

gem 'rubycas-client', require: false
gem 'rake'
gem 'delayed_job_active_record'
gem 'daemons'
gem 'unicorn', require: false
gem 'mail'

gem 'whenever', require: false

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

gem 'spring', group: :development
gem 'web-console', '~> 2.0', group: :development

gem 'turbolinks', require: false

gem 'declarative_authorization'

# For automatic inline CSS for mailer
gem 'hpricot'
gem 'premailer-rails'

# For JS-accessible routes
gem "js-routes", require: false

gem 'jbuilder', require: false

group :test, :development do
  gem 'sqlite3'
  # For debugging
  gem 'byebug'
end

group :production do
  gem "pg"
end

gem 'jquery-rails', require: false

# For Bootstrap support
gem 'bootstrap-sass', '~> 3.3.5', require: false
gem 'sass-rails', '>= 3.2', require: false

gem 'exception_notification'

# For loading remote JSON
gem 'rest-client', require: false

# For profiling memory usage of gems
gem 'derailed', group: :development
