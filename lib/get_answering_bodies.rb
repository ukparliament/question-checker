module GetAnsweringBodies
  
  # We include code to get the questions.
  include GetQuestions

  # A method to return an array of answering bodies.
  def get_answering_bodies( house )
  
    # We get all the late for answer questions.
    questions = get_questions( house, nil, nil )
    
    # We create an array to hold the answering bodies.
    answering_bodies = []
    
    # For each question ...
    questions.each do |question|
    
      # ... we look for a question in the array with the ID of the answering body for that question.
      answering_body_in_array = answering_bodies.find_all {|ab| ab.id == question.answering_body_id}.first
      
      # If we find the answering body in the array of answering bodies ...
      if answering_body_in_array
      
        # ... we add one to its question count.
        answering_body_in_array.question_count +=1
      
      # Otherwise, if we fail to find the answering body in the array of answering bodies ...
      else
        
        # ... we create a new answering body ...
        answering_body = AnsweringBody.new
        answering_body.id = question.answering_body_id
        answering_body.name = question.answering_body_name
        answering_body.question_count = 1
        
        # ... and add it to the answering bodies array.
        answering_bodies << answering_body
      end
    end
    
    # We sort the answering bodies array by name.
    answering_bodies.sort! { |a, b| a.name <=> b.name }
    
    # We return the array of answering bodies.
    answering_bodies
  end
end