class SitesController < ApplicationController
  def show
    @site = Site.find(params[:id])
  end

  def create
  end

  def edit
  end

  def update
  end
end
