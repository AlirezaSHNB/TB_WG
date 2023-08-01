class HomeController < ApplicationController
  before_action :authenticate_request

  def home
  end
end
