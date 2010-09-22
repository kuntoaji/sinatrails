require 'factory_girl/syntax/sham'
Sham.email {|n| "#{n}@example.com" }

Factory.define :user do |user|
  user.email { Sham.email }
  user.password 'secret'
  user.password_confirmation 'secret'
  user.name 'Myname'
  user.role 'admin'
end
