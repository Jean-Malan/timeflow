class IndexController < ApplicationController
  def index
    before_action :authenticate_user!
  end
end
