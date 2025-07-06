class HouseAnsweringBodyController < ApplicationController
  
  # We include code to get the answering bodies.
  include GetAnsweringBodies

  def index
    house = params[:house].to_i
    
    # If the House ID is 1 ...
    if house == 1
    
      # ... we get the answering_bodies for the House of Commons.
      @answering_bodies = get_answering_bodies( 'Commons' )
      
      # We set the page meta information.
      @page_title = 'Houses of Commons - Answering bodies with questions late for answer'
      @multiline_page_title = "House of Commons <span class='subhead'>Answering bodies with questions late for answer</span>".html_safe
      @description = "Answering bodies with questions late for answer in the Houses of Commons."
      
    # Otherwise, if the House ID is 2 ...
    elsif house == 2
    
      # ... we get the answering_bodies for the House of Lords.
      @answering_bodies = get_answering_bodies( 'Lords' )
      
      # We set the page meta information.
      @page_title = 'Houses of Lords - Answering bodies with questions late for answer'
      @multiline_page_title = "House of Lords <span class='subhead'>Answering bodies with questions late for answer</span>".html_safe
      @description = "Answering bodies with questions late for answer in the Houses of Lords."
      
    # Otherwise, if the House ID is neither 1 nor 2 ...
    else
    
      # ... we raise a record not found error.
      raise ActiveRecord::RecordNotFound
    end
    
    # We set the page meta information.
    @section = 'houses'
    @subsection = 'answering-bodies'
  end
  
  def show
  
    # We get the House and answering body from the parameters passed
    house = params[:house].to_i
    answering_body = params[:answering_body]
  
    # If the House ID is 1 ...
    if house == 1
  
      # ... we get the questions for this answering body in the House of Commons.
      @questions = get_questions( 'Commons', answering_body, nil )
    
      # We set the page meta information.
      @page_title = "Houses of Commons - Questions late for answer tabled to the #{@questions.first.answering_body_name}"
      @multiline_page_title = "House of Commons <span class='subhead'>Questions late for answer tabled to the #{@questions.first.answering_body_name}</span>".html_safe
      @description = "Questions late for answer tabled to the #{@questions.first.answering_body_name} in the House of Commons."
    
    # Otherwise, if the House ID is 2 ...
    elsif house == 2
  
      # ... we get the questions for this answering body in the House of Lords.
      @questions = get_questions( 'Lords', answering_body, nil )
    
      # We set the page meta information.
      @page_title = "Houses of Lords - Questions late for answer tabled to the #{@questions.first.answering_body_name}"
      @multiline_page_title = "House of Lords <span class='subhead'>Questions late for answer tabled to the #{@questions.first.answering_body_name}</span>".html_safe
      @description = "Questions late for answer tabled to the #{@questions.first.answering_body_name} in the House of Lords."
    
    # Otherwise, if the House ID is neither 1 nor 2 ...
    else
  
      # ... we raise a record not found error.
      raise ActiveRecord::RecordNotFound
    end
  
    # We set the page meta information.
    @section = 'houses'
    @subsection = 'answering-bodies'
  end
end
