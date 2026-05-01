source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '>= 3.2'
# gem no longer bundled as of Ruby 3.0
gem 'rexml'

gem 'rails', '~> 7.2.0'
gem 'bootsnap', require: false
# gem 'concurrent-ruby', '< 1.3.5' # https://github.com/rails/rails/pull/54264

# Use Puma as the app server
gem 'puma', '~> 6.0'

gem 'rack-cas'
gem 'rake'
gem 'delayed_job_active_record', '~> 4.1'
gem 'daemons'

gem 'mail'

gem 'whenever'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

gem 'turbolinks'

# For automatic inline CSS for mailer
# gem 'hpricot'
# gem 'premailer-rails'

# For JS-accessible routes
gem 'js-routes'

gem 'jbuilder', '~> 2.5'

gem 'mysql2', '~> 0.5.0'
gem 'sqlite3' # for testing

gem 'jquery-rails'

# For Bootstrap support
gem 'bootstrap-sass', '~> 3.4'
gem 'sassc-rails', '~> 2.1'

# For loading remote JSON
gem 'rest-client'

# For profiling memory usage of gems
gem 'derailed', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '~> 4.2'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# For AWS DynamoDB support, used in message receipts
gem 'aws-sdk-dynamodb', '~> 1.6'
gem 'aws-sdk-core', '~> 3.0'
