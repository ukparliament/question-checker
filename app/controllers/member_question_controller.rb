class MemberQuestionController < ApplicationController
  
  # We include code to get the questions.
  include GetQuestions

  def index
  
    # We get the Member ID from the parameter.
    member = params[:member]
  
    # We get the questions, passing null values for House and answering body.
    @questions = get_questions( nil, nil, member )
    
    # We set the page meta information.
    @page_title = @questions.first.asking_member_name
    @description = "#{@questions.first.asking_member_name}."
    @section = 'members'
  end
end
