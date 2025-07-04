module GetQuestions

  # We require the net http and open uri modules.
  require 'net/http'
  require 'open-uri'

  def get_questions( query )
    
    # We create an array to hold the questions.
    questions = []
  
    # We set the date for which unanswered questions are considered late for answer.
    late_for_answer_date = Date.yesterday
    
    # We set the number of results we want to take.
    take = 5000
  
    # We construct the API URL.
    url = "https://questions-statements-api.parliament.uk/api/writtenquestions/questions?dateForAnswerWhenTo=#{late_for_answer_date}&answered=Unanswered&questionStatus=NotAnswered&includeWithdrawn=false&sessionStatus=Any&expandMember=True&&take=#{take}#{query}"
    
    # We get the response from the API.
    response = Net::HTTP.get_response( URI.parse( url ) )
    
    # We get the body of the responce and parse it as JSON.
    data = response.body
    json = JSON.parse( data )
    
    # We loop through each question returned ...
    json['results'].each do |question|
    
      # ... we traverse the JSON to the value.
      question_value = question['value']
      
      # We create a new question object ...
      question = Question.new
      question.id = question_value['id']
      question.house = question_value['house']
      question.tabled_on = question_value['dateTabled'].to_date
      question.date_for_answer = question_value['dateForAnswer'].to_date
      question.uin = question_value['uin']
      question.answering_body_id = question_value['answeringBodyId']
      question.answering_body_name = question_value['answeringBodyName']
      question.is_named_day = question_value['isNamedDay']
      question.heading = question_value['heading']
      question.text = question_value['questionText']
      question.asking_member_id = question_value['askingMember']['id']
      question.asking_member_name = question_value['askingMember']['name']
      
      # ... and add it to the array of questions.
      questions << question
    end
    
    questions = questions.sort { |a, b| b.date_for_answer <=> a.date_for_answer }
    
    # We return the questions array.
    questions
  end
end