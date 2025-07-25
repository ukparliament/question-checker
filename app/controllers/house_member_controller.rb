class HouseMemberController < ApplicationController
  
  # We include code to get the Members.
  include GetMembers
  
  def index
    house = params[:house].to_i
    
    @crumb << { label: 'Houses', url: house_list_url }
    
    # If the House ID is 1 ...
    if house == 1
    
      # ... we get the Members for the House of Commons.
      @members = get_members( 'Commons' )
      
      # We set the page meta information.
      @page_title = 'Houses of Commons - Members'
      @multiline_page_title = "House of Commons <span class='subhead'>Members</span>".html_safe
      @description = "Houses of Commons Members."
      @crumb << { label: 'House of Commons', url: house_show_url }
      
    # Otherwise, if the House ID is 2 ...
    elsif house == 2
    
      # ... we get the Member for the House of Lords.
      @members = get_members( 'Lords' )
      
      # We set the page meta information.
      @page_title = 'Houses of Lords - Members'
      @multiline_page_title = "House of Lords <span class='subhead'>Members</span>".html_safe
      @description = "Houses of Lords Members."
      @crumb << { label: 'House of Lords', url: house_show_url }
      
    # Otherwise, if the House ID is neither 1 nor 2 ...
    else
    
      # ... we raise a record not found error.
      raise ActiveRecord::RecordNotFound
    end
    
    # We set the page meta information.
    @section = 'houses'
    @subsection = 'members'
    @crumb << { label: 'Members', url: nil }
    
    # We allow for table sorting.
    @sort = params[:sort]
    @order = params[:order]
    if @order and @sort
      case @order
        when 'descending'
          case @sort
            when 'member-name'
              @members.sort_by! {|member| member.sort_name}.reverse!
            when 'question-count'
              @members.sort_by! {|member| member.question_count}.reverse!
        end
        when 'ascending'
          case @sort
            when 'member-name'
              @members.sort_by! {|member| member.sort_name}
            when 'question-count'
              @members.sort_by! {|member| member.question_count}
        end
      end
    else
      @sort = 'member-name'
      @order = 'ascending'
    end
  end
end
