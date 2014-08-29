require 'bundler/setup'
Bundler.require(:default)

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["development"])

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file}

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

def designer_menu
  header
  puts "Survey Designer Menu"
  whitespace

  puts "Enter 1 to create a new survey"
  puts "Enter x to exit the system"

  case gets.chomp
  when '1'
    create_survey
  when 'x'
    exit
  else
    main_menu
  end
end

def create_survey
  header
  puts "Create Survey Menu"
  whitespace

  puts "Enter in the name of the survey you'd like to create:"
  name = gets.chomp
  new_survey = Survey.create({name: name})
  puts "#{new_survey.name} has been added!"

  puts "Would you like to add questions to this survey?  [y/n]"
  
  case gets.chomp
  when 'y'
    create_questions
  when 'n'
    designer_menu
  else
    main_menu
  end
end



main_menu