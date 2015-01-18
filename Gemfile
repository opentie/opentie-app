source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'

# Use ActiveModel has_secure_password
# Gemx 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# API router
gem 'grape'
# account authentication
gem 'devise'
# account authorization
gem 'cancancan'

# OR Mapper (for MongoDB)
gem 'mongoid', '~> 4.0.0'
gem 'mongoid-tree'

# Session store ( Redis )
gem 'redis'
gem 'redis-rails'

# tie core
gem 'opentie-core', require: 'opentie/core'

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
  gem 'mongoid-rspec'
  gem 'database_cleaner'
end

