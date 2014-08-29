require 'bundler/setup'
Bundler.require(:default, :test)

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["test"])

Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file}