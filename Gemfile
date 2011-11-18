source 'http://rubygems.org'

gem 'rails', '3.1.2'
gem 'devise'
gem 'cancan'
gem 'jquery-rails'
gem 'minitest'
gem 'mage-hand', :git => "git://github.com/yithian/mage-hand.git", :branch => "change_oauth_case"

group :assets do
  gem 'sass-rails', "  ~> 3.1.1"
  gem 'coffee-rails', "~> 3.1.1"
  gem 'uglifier'
end

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:

group :production do
  gem 'pg'
  gem 'thin'
end

group :development, :test do
  gem 'fakeweb'
  gem 'sqlite3'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end
