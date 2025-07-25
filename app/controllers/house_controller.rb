class HouseController < ApplicationController
  
  # We include code to get the questions.
  include GetQuestions

  def index
    
    # We set the page meta information.
    @page_title = 'Houses'
    @description = "Houses."
    @crumb << { label: 'Houses', url: nil }
    @section = 'houses'
  end
  
  def show
    house = params[:house].to_i
    
    @crumb << { label: 'Houses', url: house_list_url }
    
    # If the House ID is 1 ...
    if house == 1
    
      # ... we get the questions for the House of Commons.
      @questions = get_questions( 'Commons', nil, nil )
      
      # We set the page meta information.
      @page_title = 'Houses of Commons - Questions'
      @multiline_page_title = "House of Commons <span class='subhead'>Questions</span>".html_safe
      @description = "Questions tabled in the Houses of Commons."
      @crumb << { label: 'House of Commons', url: nil }
      
    # Otherwise, if the House ID is 2 ...
    elsif house == 2
    
      # ... we get the questions for the House of Lords.
      @questions = get_questions( 'Lords', nil, nil )
      
      # We set the page meta information.
      @page_title = 'Houses of Lords - Questions'
      @multiline_page_title = "House of Lords <span class='subhead'>Questions</span>".html_safe
      @description = "Questions tabled in the Houses of Lords."
      @crumb << { label: 'House of Lords', url: nil }
      
    # Otherwise, if the House ID is neither 1 nor 2 ...
    else
    
      # ... we raise a record not found error.
      raise ActiveRecord::RecordNotFound
    end
    
    # We set the page meta information.
    @csv_url = house_question_list_url( :format => 'csv' )
    @section = 'houses'
    @subsection = 'questions'
    
    render :template => 'house_question/index'
  end
end
