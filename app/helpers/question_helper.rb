module QuestionHelper

  def question_description( question )
    description = ''
    if question.is_named_day
      description += 'A named day '
    else
      description += 'An ordinary day '
    end
    description += 'question, tabled '
    description += ' in the House of '
    description += question.house
    description += ' on '
    description += question.tabled_on.strftime( $DATE_DISPLAY_FORMAT )
    description += ' to the '
    description += question.answering_body_name
    description += ' by '
    description += link_to( question.asking_member_name, "https://members.parliament.uk/member/#{question.asking_member_id}" )
    description += '.'
    description.html_safe
  end
end
