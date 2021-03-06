source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'

# Use ActiveModel has_secure_password
# Gemx 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# gem 'lucky-star'

# API router
gem 'grape'
# account authentication
gem 'devise'
gem 'bcrypt-ruby', '3.1.2'
# account authorization
gem 'cancancan'

# open id omniauth
gem 'omniauth'
gem 'omniauth-openid-connect'

# OR Mapper
gem 'pg'
gem 'activerecord'
gem 'activerecord-import'

# Session store ( Redis )
gem 'redis'
gem 'redis-rails'

# soft delete gem
gem 'kakurenbo-puti'

gem 'activeadmin', github: 'activeadmin'

# validation & form generation
gem 'formalizr', git: 'https://github.com/opentie/formalizr.git'

group :assets do
  gem 'uglifier'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # debugger
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'better_errors'

  # test
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'guard'
  gem 'guard-rspec'
  gem 'spring-commands-rspec'
  gem 'database_cleaner'
end

