require 'bundler/setup'
Bundler.require(:default)

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["development"])

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file}

@current_survey
@current_question
@current_survey_taker

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
  puts "Welcome the Survey System"
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

  puts "Enter 1 to create a new survey."
  puts "Enter 2 to create new questions."
  puts "Enter 3 to create new responses."
  puts "Enter 4 to list all surveys."
  puts "Enter 5 to list all questions."
  puts "Enter 6 to list all responses."
  puts "Press m to return to the main menu."
  puts "Enter x to exit the system"

  case gets.chomp
  when '1'
    create_survey
  when '2'
    create_question
  when '3'
    create_response
  when '4'
    list_surveys
    puts "Press any key to continue."
    gets.chomp
    designer_menu
  when '5'
    list_questions
    puts "Press any key to continue."
    gets.chomp
    designer_menu
  when '6'
    list_responses
    puts "Press any key to continue."
    gets.chomp
    designer_menu
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
  puts "Press m to return to the main menu."
  puts "Press x to exit."
  
  case gets.chomp
  when 'y'
    @current_survey = Survey.find(new_survey.id)
    create_question
  when 'n'
    @current_survey = nil
    designer_menu
  when 'm'
    main_menu
  when 'x'
    exit
  end
end

def create_question
  header
  puts "Create Question Menu"
  whitespace

  if @current_survey != nil
    puts "Current Survey: #{@current_survey.name}\n"
  end

  if @current_survey == nil
    list_surveys
    puts "Please select the survey you'd like to add questions to:"
    selected_survey = gets.chomp
    @current_survey = Survey.find(selected_survey)
    puts "Current Survey: #{@current_survey.name}\n"
    puts "Enter in the question you'd like to add to the current survey:\n"
    name = gets.chomp
    new_question = Question.create({name: name, survey_id: @current_survey.id})
    puts "#{new_question.name} has been added to #{@current_survey.name}\n\n"
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
  end
end

def create_response
  header
  puts "Create Response Menu"
  whitespace

  if @current_question != nil
    puts "Current question: #{@current_question.name}\n"
  end

  if @current_question ==nil
    list_questions
    puts "Please select the question you'd like to add responses to:"
    selected_question = gets.chomp
    @current_question = Question.find(selected_question)
    puts "Current question: #{@current_question.name}\n"
    puts "Enter in the response you'd like to add to the current question:\n"
    name = gets.chomp
    new_response = Response.create({name: name, question_id: @current_question.id})
    puts "#{new_response.name} has been added to #{@current_question.name}\n\n"
    puts "Press y if you would like add another response."
    puts "Press d if you would like to return to the designer menu."
    puts "Press x if you would like to return to the main menu."

    case gets.chomp
    when 'y'
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
  end
end

def list_surveys
  header
  puts "All Surveys:"
  Survey.all.each do |survey|
    puts "#{survey.id}.  #{survey.name}"
  end
end

def list_questions
  header
  puts "All Questions:"
  Question.all.each do |question|
    puts "#{question.id}.  #{question.name} in Survey: #{question.survey.name}"
  end
end

def list_responses
  header
  puts "All Responses:"
  Response.all.each do |response|
    puts "#{response.id}.  #{response.name} to Question: #{response.question.name} in Survey: #{response.question.survey.name}"
  end
end

def taker_menu
  header
  puts "Survey Taker Menu"
  whitespace

  if @current_survey_taker == nil
    puts "Please enter your name:"
    @current_survey_taker = SurveyTaker.find_or_create_by(name: gets.chomp)
  end

  if @current_survey_taker != nil
    puts "Choose a survey to take:"
    list_surveys
    chosen_survey = gets.chomp
    taker_chosen_survey = Survey.find(chosen_survey)
    Question.all.where(survey_id: taker_chosen_survey.id).each do |question|
      puts "#{question.name}"
      Response.all.where(question_id: question.id).each do |response|
        puts "#{response.id}. #{response.name}"
      end
      puts "Enter the number of your choice:"
      taker_response = gets.chomp
      SurveyResponse.new(survey_taker_id: current_survey_taker.id, survey_id: taker_chosen_survey.id, question_id: question.id, response_id: taker_response)
      puts "Response recorded!\n\n"
    end
    puts "Survey completed!\n\n"
    puts "Press a to take another survey."
    puts "Press m to return to the main menu."
    puts "Press x to exit."

    case gets.chomp
    when 'a'
      taker_menu
    when 'm'
      main_menu
    when 'x'
      exit
    end
  end
end


main_menu