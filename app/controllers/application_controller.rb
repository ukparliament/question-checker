class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  
  include LibraryDesign::Crumbs
  
  $SITE_TITLE = 'Question Checker'
  
  $DATE_DISPLAY_FORMAT = '%-d %B %Y'
  
  $TOGGLE_PORTCULLIS = ENV.fetch( "TOGGLE_PORTCULLIS", 'off' )
end
