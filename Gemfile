source 'https://rubygems.org'

# Specify your gem's dependencies in blacklight-geo.gemspec
gemspec

gem 'simplecov', require: false
gem 'coveralls', require: false

file = File.expand_path("Gemfile", ENV['ENGINE_CART_DESTINATION'] || ENV['RAILS_ROOT'] || File.expand_path("../spec/internal", __FILE__))
if File.exists?(file)
  puts "Loading #{file} ..." if $DEBUG # `ruby -d` or `bundle -v`
  instance_eval File.read(file)
end
