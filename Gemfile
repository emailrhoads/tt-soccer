# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'bootsnap', require: false
gem 'email_validator'
gem 'faker'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.1'
gem 'sorcery'
gem 'sqlite3', '~> 1.4'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'city-state' # used to generate Country enumeration
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'pry'
  gem 'pry-rails'
  gem 'rspec-rails'
end

group :development do
  gem 'rubocop'
  gem 'rubocop-rails'
end
