source 'http://mirror1.prod.rhcloud.com/mirror/ruby/'

gem 'rails', '3.2.3'
gem 'devise'
gem 'cancan'
gem 'jquery-rails'
gem 'minitest'
gem 'mage-hand', :git => "git://github.com/yithian/mage-hand.git", :branch => "change_oauth_case"

group :assets do
  gem 'sass-rails', "  ~> 3.2.0"
  gem 'coffee-rails', "~> 3.2.0"
  gem 'uglifier'
end

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:

group :production do
  gem 'rake', "0.8.7"
  gem 'mysql2'
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
