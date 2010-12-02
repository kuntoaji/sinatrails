source :rubygems
gem 'sinatra', '1.1.0', :require => 'sinatra/base'
gem 'activerecord', '3.0.3', :require => 'active_record'
gem 'haml'
gem 'mysql2'
gem 'will_paginate', '~> 3.0.beta', :require => 'will_paginate/finders/base'
gem 'rack-flash'
gem 'newrelic_rpm'
gem 'mail'

#group :cache do
  #gem 'sinatra-cache', :require => 'sinatra/cache'
  #gem 'memcache-client'
  #gem 'rack-cache', :require => 'rack/cache'
#end

group :development do
  gem 'thin'
end

group :test do
  gem 'database_cleaner', '0.5.2'
  gem 'factory_girl', '1.3.2'
  gem 'capybara', '0.3.9', :require => ['capybara', 'capybara/dsl']
  gem 'launchy'
  gem 'shoulda', '2.11.3'
end

group :deployment do
  gem 'vlad-git', '2.1.0'
  gem 'vlad', '2.1.0'
end
