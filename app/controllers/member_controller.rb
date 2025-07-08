class MemberController < ApplicationController
  
  # We include code to get the Members.
  include GetMembers

  def index
  
    # We get the Members with questions late for answer, passing a null value for the House.
    @members = get_members( nil )
    
    # We set the page meta information.
    @page_title = 'Tabling Members'
    @description = "Tabling Members."
    @section = 'members'
  end
  
  def show
  
    # We get the Member ID from the parameter.
    member = params[:member]
  
    # We get the questions, passing null values for House and answering body.
    @questions = get_questions( nil, nil, member )
    
    # We set the page meta information.
    @page_title = @questions.first.asking_member_name
    @description = "#{@questions.first.asking_member_name}."
    @csv_url = member_question_list_url( :format => 'csv' )
    @section = 'members'
    
    render :template => 'member_question/index'
  end
end
