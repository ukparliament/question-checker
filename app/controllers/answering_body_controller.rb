class AnsweringBodyController < ApplicationController
  
  # We include code to get the answering bodies.
  include GetAnsweringBodies

  def index
  
    # We get the answering bodies with questions late for answer, passing a null value for the House.
    @answering_bodies = get_answering_bodies( nil )
    
    # We set the page meta information.
    @page_title = 'Answering bodies'
    @description = "Answering bodies."
    @section = 'answering-bodies'
  end
  
  def show
  
    # We get the answering body ID from the parameter.
    answering_body = params[:answering_body]
  
    # We get the questions, passing null values for House and Member.
    @questions = get_questions( nil, answering_body, nil )
    
    # We set the page meta information.
    @page_title = @questions.first.answering_body_name
    @description = "#{@questions.first.answering_body_name}."
    @csv_url = answering_body_question_list_url( :format => 'csv' )
    @section = 'answering-bodies'
    
    render :template => 'answering_body_question/index'
  end
end
