class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_writers

  def get_writers
    @writers ||= User.order("updated_at DESC").all
  end
end
