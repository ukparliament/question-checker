class MetaController < ApplicationController

  def index
    @page_title = 'About this website'
    @description = "About this website."
  end

  def cookies
    @page_title = 'Cookies'
    @description = "Cookies."
  end
end
