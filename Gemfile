source 'http://rubygems.org/'

gem 'rails', '3.2.9'
gem 'rake'
gem 'mysql2'
gem 'thin'
gem 'devise'
gem 'cancan'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'mage-hand', :git => "git://github.com/yithian/mage-hand.git", :branch => "change_oauth_case"
gem 'will_paginate'
gem 'will_paginate-bootstrap'
gem 'dice_roller'

group :assets do
  gem 'sass-rails', "  ~> 3.2.0"
  gem 'coffee-rails', "~> 3.2.0"
  gem 'uglifier'
end

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:

group :production do
end

group :development, :test do
  gem 'minitest'
  gem 'fakeweb'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
  gem 'ruby-prof'
end
