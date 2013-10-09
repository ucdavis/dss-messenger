source 'https://rubygems.org'

gem 'rails', '3.2.14'

gem 'rubycas-client'
gem 'rake'
gem 'delayed_job_active_record'
gem 'daemons'
gem 'unicorn'
gem 'mail'
gem 'whenever'

gem 'declarative_authorization'

# For automatic inline CSS for mailer
gem 'hpricot'
gem 'premailer-rails' 

# For pagination
gem 'kaminari'

gem 'capistrano', '< 3.0.0'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :test, :development do
  gem 'sqlite3'
end

group :production do
  gem "pg"
end

gem 'jquery-rails'

gem "twitter-bootstrap-rails"

gem 'rails-backbone', :git => 'git://github.com/codebrew/backbone-rails.git'

gem 'exception_notification'
