require 'bundler/setup'
Bundler.require(:default)

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["development"])

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file}

@current_survey
@current_question

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
  puts "Enter 2 to create new questions"
  puts "Press m to return to the main menu."
  puts "Enter x to exit the system"

  case gets.chomp
  when '1'
    create_survey
  when '2'
    create_question
  when '3'
    create_response
  when 'm'
    main_menu
  when 'x'
    exit
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

  puts "Would you like to add questions to this survey?"
  puts "Press y to add a question to this survey."
  puts "Press n to return to the designer menu."
  puts "Or press x to return to the main_menu"
  
  case gets.chomp
  when 'y'
    @current_survey = Survey.find(new_survey.id)
    create_question
  when 'n'
    @current_survey = nil
    designer_menu
  else
    main_menu
  end
end

def create_question
  header
  puts "Create Question Menu"
  whitespace

  if @current_survey != nil
    puts "Current Survey: #{@current_survey.name}\n"
    puts "Enter in the question you'd like to add to the current survey:\n"
    name = gets.chomp
    new_question = Question.create({name: name, survey_id: @current_survey.id})
    puts "#{new_question.name} has been added to #{@current_survey.name}\n"
    puts "Press y if you would like add another question."
    puts "Press n if you would like to add a response to the question."
    puts "Press d if you would like to return to the designer menu."
    puts "Press x if you would like to return to the main menu."

    case gets.chomp
    when 'y'
      create_question
    when 'n'
      @current_question = Question.find(new_question.id)
      create_response
    when 'd'
      @current_survey = nil
      @current_question = nil
      designer_menu
    when 'x'
      @current_survey = nil
      @current_question = nil
      main_menu
    end
  elsif @current_survey == nil
    list_surveys
    binding.pry
  end
end

def list_surveys
  header
  puts "All Surveys:"
  Survey.all.each do |survey|
    puts "#{survey.id}.  #{survey.name}"
  end
end


main_menu