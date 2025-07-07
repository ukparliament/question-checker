module QuestionHelper

  def question_description( question )
    description = ''
    if question.is_named_day
      description += 'A named day '
    else
      description += 'An ordinary day '
    end
    description += 'question, tabled in the '
    if question.house == 'Commons'
      description += link_to( 'House of Commons', house_show_url( :house => 1 ) )
    else
      description += link_to( 'House of Lords', house_show_url( :house => 2 ) )
    end
    description += ' on '
    description += question.tabled_on.strftime( $DATE_DISPLAY_FORMAT )
    description += ' to the '
    description += link_to( question.answering_body_name, answering_body_show_url( :answering_body => question.answering_body_id ) )
    description += ' by '
    description += link_to( question.asking_member_name, member_show_url( :member => question.asking_member_id ) )
    description += '.'
    description.html_safe
  end
end
