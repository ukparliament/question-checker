class AnsweringBodyQuestionController < ApplicationController
  
  # We include code to get the questions.
  include GetQuestions

  def index
  
    # We get the answering body ID from the parameter.
    answering_body = params[:answering_body]
  
    # We get the questions, passing null values for House and Member.
    @questions = get_questions( nil, answering_body, nil )
    
    # We set the page meta information.
    @page_title = @questions.first.answering_body_name
    @description = "#{@questions.first.answering_body_name}."
    @section = 'answering-bodies'
  end
end
