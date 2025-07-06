module GetMembers
  
  # We include code to get the questions.
  include GetQuestions

  # A method to return an array of Members.
  def get_members( house )
  
    # We get all the late for answer questions.
    questions = get_questions( house, nil, nil )
    
    # We create an array to hold the members.
    members = []
    
    # For each question ...
    questions.each do |question|
    
      # ... we look for a question in the array with the ID of the member for that question.
      member_in_array = members.find_all {|ab| ab.id == question.asking_member_id}.first
      
      # If we find the Member in the array of Members ...
      if member_in_array
      
        # ... we add one to its question count.
        member_in_array.question_count +=1
      
      # Otherwise, if we fail to find the Member in the array of Members ...
      else
        
        # ... we create a new Member ...
        member = Member.new
        member.id = question.asking_member_id
        member.name = question.asking_member_name
        member.sort_name = question.asking_member_sort_name
        member.question_count = 1
        
        # ... and add it to the Members array.
        members << member
      end
    end
    
    # We sort the Members array by sort name.
    members.sort! { |a, b| a.sort_name <=> b.sort_name }
    
    # We return the array of Members.
    members
  end
end