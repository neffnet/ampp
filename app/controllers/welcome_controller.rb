class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      @sites = current_user.sites
    end
  end
end
