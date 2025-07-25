class HouseAnsweringBodyController < ApplicationController
  
  # We include code to get the answering bodies.
  include GetAnsweringBodies

  def index
    house = params[:house].to_i
    
    @crumb << { label: 'Houses', url: house_list_url }
    
    # If the House ID is 1 ...
    if house == 1
    
      # ... we get the answering_bodies for the House of Commons.
      @answering_bodies = get_answering_bodies( 'Commons' )
      
      # We set the page meta information.
      @page_title = 'Houses of Commons - Answering bodies'
      @multiline_page_title = "House of Commons <span class='subhead'>Answering bodies</span>".html_safe
      @description = "Answering bodies with questions in the Houses of Commons."
      @crumb << { label: 'House of Commons', url: house_show_url }
      
    # Otherwise, if the House ID is 2 ...
    elsif house == 2
    
      # ... we get the answering_bodies for the House of Lords.
      @answering_bodies = get_answering_bodies( 'Lords' )
      
      # We set the page meta information.
      @page_title = 'Houses of Lords - Answering bodies'
      @multiline_page_title = "House of Lords <span class='subhead'>Answering bodies</span>".html_safe
      @description = "Answering bodies with questions in the Houses of Lords."
      @crumb << { label: 'House of Lords', url: house_show_url }
      
    # Otherwise, if the House ID is neither 1 nor 2 ...
    else
    
      # ... we raise a record not found error.
      raise ActiveRecord::RecordNotFound
    end
    
    # We set the page meta information.
    @crumb << { label: 'Answering bodies', url: nil }
    @section = 'houses'
    @subsection = 'answering-bodies'
    
    # We allow for table sorting.
    @sort = params[:sort]
    @order = params[:order]
    if @order and @sort
      case @order
        when 'descending'
          case @sort
            when 'answering-body'
              @answering_bodies.sort_by! {|answering_body| answering_body.name}.reverse!
            when 'question-count'
              @answering_bodies.sort_by! {|answering_body| answering_body.question_count}.reverse!
        end
        when 'ascending'
          case @sort
            when 'answering-body'
              @answering_bodies.sort_by! {|answering_body| answering_body.name}
            when 'question-count'
              @answering_bodies.sort_by! {|answering_body| answering_body.question_count}
        end
      end
    else
      @sort = 'answering-body'
      @order = 'ascending'
    end
  end
  
  def show
  
    # We get the House and answering body from the parameters passed
    house = params[:house].to_i
    answering_body = params[:answering_body]
  
    # If the House ID is 1 ...
    if house == 1
  
      # ... we get the questions for this answering body in the House of Commons.
      @questions = get_questions( 'Commons', answering_body, nil )
      
      # We set the House name.
      house_name = 'House of Commons'
      
    # Otherwise, if the House ID is 2 ...
    elsif house == 2
  
      # ... we get the questions for this answering body in the House of Lords.
      @questions = get_questions( 'Lords', answering_body, nil )
      
      # We set the House name.
      house_name = 'House of Lords'
    
    # Otherwise, if the House ID is neither 1 nor 2 ...
    else
  
      # ... we raise a record not found error.
      raise ActiveRecord::RecordNotFound
    end
    
    # We respond to CSV and HTML.
    respond_to do |format|
      format.csv {
        response.headers['Content-Disposition'] = "attachment; filename=\"#{house_name.downcase.gsub(' ', '-')}-questions-tabled-to-#{@questions.first.answering_body_name.downcase.gsub(' ', '-').gsub(',', '')}.csv\""
        render :template => 'question/index'
      }
      format.html {
        
        # We set the page meta information.
        @page_title = "#{house_name} - Questions tabled to the #{@questions.first.answering_body_name}"
        @multiline_page_title = "#{house_name} <span class='subhead'>Questions tabled to the #{@questions.first.answering_body_name}</span>".html_safe
        @description = "Questions tabled to the #{@questions.first.answering_body_name} in the #{house_name}."
        @csv_url = house_answering_body_show_url( :format => 'csv' )
        @crumb << { label: 'Houses', url: house_list_url }
        @crumb << { label: house_name, url: house_show_url }
        @crumb << { label: 'Answering bodies', url: house_answering_body_list_url }
        @crumb << { label: @questions.first.answering_body_name, url: nil }
        @section = 'houses'
        @subsection = 'answering-bodies'
      }
    end
  end
end
