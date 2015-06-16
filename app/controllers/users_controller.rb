class UsersController < ApplicationController
  def show
    @user = current_user
    @sites = @user.sites
  end
end
