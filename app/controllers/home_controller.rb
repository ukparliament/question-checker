class HomeController < ApplicationController
  
  # We include code to get the questions.
  include GetQuestions
  
  def index
  
    # We get the questions, passing null values for House, answering body and Member.
    @questions = get_questions( nil, nil, nil )
    
    # We set the page meta information.
    @page_title = 'All questions - Late for answer'
    @multiline_page_title = "All questions <span class='subhead'>Late for answer</span>".html_safe
    @description = "All questions late for answer."
    @section = 'questions'
    
    render :template => 'question/index'
  end
end
