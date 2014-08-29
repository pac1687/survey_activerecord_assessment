require 'bundler/setup'
Bundler.require(:default)

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["development"])

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file}

@current_cashier
@current_customer

def whitespace
  puts "\n"
end

def header
  system 'clear'
  puts "Survey System"
  puts "=" * 60
  whitespace
end

def main_menu
  header
  puts "Welcome the Survey system"
  puts "Enter 1 if you are a survey designer"
  puts "Enter 2 if you are a survey taker"
  puts "Enter x to exit the system"

  case gets.chomp
  when '1'
    designer_menu
  when '2'
    taker_menu
  when 'x'
    exit
  else
    main_menu
  end
end

main_menu