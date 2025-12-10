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
      }
      format.html {
      
        # We set the page meta information.
        @page_title = @questions.first.answering_body_name
        @description = "#{@questions.first.answering_body_name}."
        @canonical_url = answering_body_show_url
        @csv_url = answering_body_question_list_url( :format => 'csv' )
        @crumb << { label: 'Answering bodies', url: answering_body_list_url }
        @crumb << { label: @questions.first.answering_body_name, url: answering_body_show_url }
        @crumb << { label: 'Questions', url: nil }
        @section = 'answering-bodies'
      }
    end
    render :template => 'question/index'
  end
end
