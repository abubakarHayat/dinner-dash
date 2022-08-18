class AdminsController < ApplicationController
  def index
    @user = current_user
    authorize @user
  end
end
