class AnsweringBodyQuestionController < ApplicationController
  
  # We include code to get the questions.
  include GetQuestions

  def index
  
    # We get the answering body ID from the parameter.
    answering_body = params[:answering_body]
  
    # We get the questions, passing null values for House and Member.
    @questions = get_questions( nil, answering_body, nil )
    
    # We respond to CSV and HTML.
    respond_to do |format|
      format.csv {
        response.headers['Content-Disposition'] = "attachment; filename=\"questions-tabled-to-#{@questions.first.answering_body_name.downcase.gsub(' ', '-').gsub(',', '')}.csv\""
        render :template => 'question/index'
      }
      format.html {
      
        # We set the page meta information.
        @page_title = @questions.first.answering_body_name
        @description = "#{@questions.first.answering_body_name}."
        @csv_url = answering_body_question_list_url( :format => 'csv' )
        @section = 'answering-bodies'
      }
    end
  end
end
