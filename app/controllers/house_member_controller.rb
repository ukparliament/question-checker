class HouseMemberController < ApplicationController
  
  # We include code to get the Members.
  include GetMembers
  
  def index
    house = params[:house].to_i
    
    # If the House ID is 1 ...
    if house == 1
    
      # ... we get the Members for the House of Commons.
      @members = get_members( 'Commons' )
      
      # We set the page meta information.
      @page_title = 'Houses of Commons - Members with questions late for answer'
      @multiline_page_title = "House of Commons <span class='subhead'>Members with questions late for answer</span>".html_safe
      @description = "Houses of Commons Members with questions late for answer."
      
    # Otherwise, if the House ID is 2 ...
    elsif house == 2
    
      # ... we get the Member for the House of Lords.
      @members = get_members( 'Lords' )
      
      # We set the page meta information.
      @page_title = 'Houses of Lords - Members with questions late for answer'
      @multiline_page_title = "House of Lords <span class='subhead'>Members with questions late for answer</span>".html_safe
      @description = "Houses of Lords Members with questions late for answer."
      
    # Otherwise, if the House ID is neither 1 nor 2 ...
    else
    
      # ... we raise a record not found error.
      raise ActiveRecord::RecordNotFound
    end
    
    # We set the page meta information.
    @section = 'houses'
    @subsection = 'members'
  end
end
