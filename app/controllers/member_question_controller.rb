class MemberQuestionController < ApplicationController
  
  # We include code to get the questions.
  include GetQuestions

  def index
  
    # We get the Member ID from the parameter.
    member = params[:member]
  
    # We get the questions, passing null values for House and answering body.
    @questions = get_questions( nil, nil, member )
    
    # We respond to CSV and HTML.
    respond_to do |format|
      format.csv {
        response.headers['Content-Disposition'] = "attachment; filename=\"questions-tabled-by-#{@questions.first.asking_member_name.downcase.gsub(' ', '-')}.csv\""
        render :template => 'question/index'
      }
      format.html {
      
        # We set the page meta information.
        @page_title = @questions.first.asking_member_name
        @description = "#{@questions.first.asking_member_name}."
        @csv_url = member_question_list_url( :format => 'csv' )
        @section = 'members'
      }
    end
  end
end
