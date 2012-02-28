source :rubygems

# Server requirements (defaults to WEBrick)
# gem 'thin'
# gem 'mongrel'

# Project requirements
gem 'rake'
gem 'sinatra-flash', :require => 'sinatra/flash'

# Component requirements
gem 'bcrypt-ruby', :require => "bcrypt"
gem 'haml'
gem 'activerecord', :require => "active_record"
gem 'sqlite3'
gem 'rest-client'

# Test requirements
gem 'rspec', :group => "test"
gem 'mocha', :group => "test"
gem 'fakeweb', :group => "test"
gem 'cucumber-sinatra', :group => "test"
gem 'cucumber', :group => "test"
gem 'capybara', :group => "test"
gem 'rack-test', :require => "rack/test", :group => "test"
gem 'factory_girl', :require => "factory_girl", :group => "test"
gem 'database_cleaner', :group => "test"

# Padrino Stable Gem
gem 'padrino', '0.10.5'


# Or Padrino Edge
# gem 'padrino', :git => 'git://github.com/padrino/padrino-framework.git'

# Or Individual Gems
# %w(core gen helpers cache mailer admin).each do |g|
#   gem 'padrino-' + g, '0.10.5'
# end
group :development do
  gem 'guard'
  gem 'rb-readline'
  gem 'libnotify'
  gem 'growl'
end
