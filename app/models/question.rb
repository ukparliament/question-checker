class Question
  
  attr_accessor :id
  attr_accessor :house
  attr_accessor :tabled_on
  attr_accessor :date_for_answer
  attr_accessor :uin
  attr_accessor :answering_body_id
  attr_accessor :answering_body_name
  attr_accessor :is_named_day
  attr_accessor :heading
  attr_accessor :text
  attr_accessor :asking_member_id
  attr_accessor :asking_member_name
  
  def title
    self.heading || 'Untitled'
  end
  
  def url
    "https://questions-statements.parliament.uk/written-questions/detail/#{self.tabled_on}/#{self.uin}"
  end
end