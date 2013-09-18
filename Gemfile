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

#for automatic inline css in mailer
gem 'hpricot'
gem 'premailer-rails' 

#for pagination
gem 'kaminari'

gem 'capistrano'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

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
