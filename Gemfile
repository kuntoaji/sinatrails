source :rubygems
gem 'sinatra', '1.0.0', :require => 'sinatra/base'
gem 'activerecord', '3.0.0', :require => 'active_record'
gem 'haml', '3.0.18'
gem 'mysql'
gem 'will_paginate', :git => 'git://github.com/mislav/will_paginate.git', 
  :tag => 'v3.0.pre2', 
  :require => 'will_paginate/finders/base'
gem 'rack-flash'

gem 'thin', :group => :development

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
