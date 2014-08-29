#Active Record Assessment - Survey#

#####Written by [Justin Pacubas] (https://github.com/pac1687)

###About:

This program was written as my assessment in Databases with Active Record for Epicodus Summer 2014

###Description:
This program allows a survey designer to create a new survey, add questions to surveys, and add responses to each question.  Each question is a multiple choice, choose one response format.  It also allows a survey taker to choose which survey they'd like to take, view questions one at a time and choose among the possible responses for each question.

===============================
####Features
+ Menu for a survey designer
+ Menu for a survey taker
+ Create new surveys, questions, and responses.
+ List all surveys, questions, or responses.

####Requirements
* The current stable version of Ruby 2.1.2.
* Text Editor (Sublime 3 beta)
* Postgresql

#####Instructions:
1. Download zip file
2. Run bundle install
3. Run rake db:create
4. Run rake db:migrate
5. Run ruby survey_ui.rb

##Schema:
This program utilizes a postgresql database labeled 'survey_development' with the following schema:

![Survey Schema](http://i.imgur.com/FhzoYZC.png)

####License:
MIT