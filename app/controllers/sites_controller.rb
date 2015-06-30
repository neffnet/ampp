class SitesController < ApplicationController
  def new
    @site = Site.new
  end

  def create
    @site = current_user.sites.build(site_params)

    if @site.save
      flash[:notice] = "#{@site.name} site created!" 
      redirect_to @site
    else
      flash[:error] = @site.errors
      render :new
    end
  end

  def show
    @site = Site.find(params[:id])
  end

  protected

  def site_params
    params.require(:site).permit(:name, :facebook_page_id)
  end
end
