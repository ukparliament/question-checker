module GetQuestions

  # We require the net http and open uri modules.
  require 'net/http'
  require 'open-uri'

  # A method to return an array of questions.
  def get_questions( house, answering_body, asking_member )
    
    # We create an array to hold the questions.
    questions = []
  
    # We set the date for which unanswered questions are considered late for answer.
    late_for_answer_date = Date.yesterday
    
    # We set the number of results we want to take.
    take = 5000
  
    # We construct the API URL.
    url = "https://questions-statements-api.parliament.uk/api/writtenquestions/questions?dateForAnswerWhenTo=#{late_for_answer_date}&answered=Unanswered&questionStatus=NotAnswered&includeWithdrawn=false&sessionStatus=Any&expandMember=True&take=#{take}"
    url += "&house=#{house}" if house
    url += "&answeringBodies=#{answering_body}" if answering_body
    url += "&askingMemberId=#{asking_member}" if asking_member
    
    # We get the response from the API.
    response = Net::HTTP.get_response( URI.parse( url ) )
    
    # We get the body of the responce and parse it as JSON.
    data = response.body
    json = JSON.parse( data )
    
    # We loop through each question returned ...
    json['results'].each do |question|
    
      # ... we traverse the JSON to the value.
      question_value = question['value']
      
      # We get the information we need to determine the date for answer.
      house = question_value['house']
      tabled_on = question_value['dateTabled'].to_date
      published_date_for_answer = question_value['dateForAnswer'].to_date
      is_named_day = question_value['isNamedDay']
      
      # We determine the date for answer.
      determined_date_for_answer = determine_date_for_answer( house, tabled_on, published_date_for_answer, is_named_day )
      
      # We know that the determine date for answer method returns a nil value for 'ordinary' questions tabled less than eight days ago in the House of Commons.
      # If we have determined a date for answer ...
      if determined_date_for_answer
      
        # ... we create a new question object ...
        question = Question.new
        question.id = question_value['id']
        question.house = house
        question.tabled_on = tabled_on
        question.uin = question_value['uin']
        question.answering_body_id = question_value['answeringBodyId']
        question.answering_body_name = question_value['answeringBodyName']
        question.is_named_day = is_named_day
        question.heading = question_value['heading']
        question.text = question_value['questionText']
        question.asking_member_id = question_value['askingMember']['id']
        question.asking_member_name = question_value['askingMember']['name']
        question.asking_member_sort_name = question_value['askingMember']['listAs']
        
        # ... assigning it the date for answer we determined ...
        question.date_for_answer = determined_date_for_answer
        
      
        # ... and add it to the array of questions.
        questions << question
      end
    end
    
    # We sort the questions array by date for answer.
    questions.sort! { |a, b| b.date_for_answer <=> a.date_for_answer }
    
    # We return the questions array.
    questions
  end
  
  # A method to determine the date for answer.
  def determine_date_for_answer( house, tabled_on, published_date_for_answer, is_named_day )
  
    # We create a variable to store the date for answer.
    date_for_answer = nil
    
    # If the question has been tabled in the House of Lords ...
    if house == 'Lords'
      
      # ... we set the date for answer to the published date for answer, knowing that date for answer is set correctly in the House of Lords.
      date_for_answer = published_date_for_answer
    
    # Otherwise, if the question has been tabled in the House of Commons ...
    elsif house = 'Commons'
    
      # If he question is a named day question.
      if is_named_day
      
        # ... we set the date for answer to the published date for answer.
        date_for_answer = published_date_for_answer
        
      # Otherwise, if the question is an 'ordinary' question ...
      else
      
        # ... we base the logic on the convention that an MP can expect an ordinary day question to be answered within seven days of the question being tabled, as [outlined here](https://www.parliament.uk/about/how/business/written-answers/).
        # We set the tabling cut-off date to eight days before today.
        tabling_cut_off_date = Date.today - 8
        
        # If the tabling date is on or before the tabling cut off date ...
        if tabled_on <= tabling_cut_off_date
          
          # ... we set the date for answer to the tabling date plus seven days.
          date_for_answer = tabled_on + 7.days
          
        # Otherwise, if the tabling date is later than the cut off date ...
        else
        
          # We do nothing because we want this method to return a nil date for answer.
        end
      end
    
    # Otherwise, if the question has been tabled in neither the House of Lords not the House of Commons ...
    else
    
      # Something has gone wrong.
      puts "Question assigned to neither House"
    end
    
    # We return the date for answer.
    date_for_answer
  end
end