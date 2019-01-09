class LandingController < ApplicationController
  def index
    before_action :authenticate_user!
  end
end
