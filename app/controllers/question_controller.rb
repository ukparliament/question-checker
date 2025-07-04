class QuestionController < ApplicationController
  
  # We include code to get the questions.
  include GetQuestions

  def index
  
    # We get the questions.
    @questions = get_questions( '' )
  end
end
