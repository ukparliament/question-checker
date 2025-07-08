class HouseQuestionController < ApplicationController
  
  # We include code to get the questions.
  include GetQuestions
  
  def index
    house = params[:house].to_i
    
    # If the House ID is 1 ...
    if house == 1
    
      # ... we get the questions for the House of Commons.
      @questions = get_questions( 'Commons', nil, nil )
      
      # We set the House name.
      house_name = 'House of Commons'
      
    # Otherwise, if the House ID is 2 ...
    elsif house == 2
    
      # ... we get the questions for the House of Lords.
      @questions = get_questions( 'Lords', nil, nil )
      
      # We set the House name.
      house_name = 'House of Lords'
      
    # Otherwise, if the House ID is neither 1 nor 2 ...
    else
    
      # ... we raise a record not found error.
      raise ActiveRecord::RecordNotFound
    end
    
    # We respond to CSV and HTML.
    respond_to do |format|
      format.csv {
        response.headers['Content-Disposition'] = "attachment; filename=\"#{house_name.downcase.gsub(' ', '-')}-questions.csv\""
        render :template => 'question/index'
      }
      format.html {
        
        # We set the page meta information.
        @page_title = "#{house_name} - Questions"
        @multiline_page_title = "#{house_name} <span class='subhead'>Questions</span>".html_safe
        @description = "Questions tabled in the #{house_name}."
        @csv_url = house_question_list_url( :format => 'csv' )
        @section = 'houses'
        @subsection = 'questions'
      }
    end
  end
end
