class HouseQuestionController < ApplicationController
  
  # We include code to get the questions.
  include GetQuestions
  
  def index
    house = params[:house].to_i
    
    # If the House ID is 1 ...
    if house == 1
    
      # ... we get the questions for the House of Commons.
      @questions = get_questions( 'Commons', nil, nil )
      
      # We set the page meta information.
      @page_title = 'Houses of Commons - Questions'
      @multiline_page_title = "House of Commons <span class='subhead'>Questions</span>".html_safe
      @description = "Questions tabled in the Houses of Commons."
      
    # Otherwise, if the House ID is 2 ...
    elsif house == 2
    
      # ... we get the questions for the House of Lords.
      @questions = get_questions( 'Lords', nil, nil )
      
      # We set the page meta information.
      @page_title = 'Houses of Lords - Question'
      @multiline_page_title = "House of Lords <span class='subhead'>Questions</span>".html_safe
      @description = "Questions tabled in the Houses of Lords."
      
    # Otherwise, if the House ID is neither 1 nor 2 ...
    else
    
      # ... we raise a record not found error.
      raise ActiveRecord::RecordNotFound
    end
    
    # We set the page meta information.
    @section = 'houses'
    @subsection = 'questions'
  end
end
