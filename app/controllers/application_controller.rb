class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  class Entry
  	def initialize(title, link, locations)
  		@title = title
  		@link = link
      @locations = locations
  	end
  	attr_reader :title
  	attr_reader :link
    attr_reader :locations
  end
end
