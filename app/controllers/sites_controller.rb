class SitesController < ApplicationController
  def show
    @site = Site.find(params[:id])
  end

  def new
    @site = current_user.sites.build()
  end

  def create
    @site = current_user.sites.build(site_params)

    if @site.save
      flash[:notice] = "New site created!"
      redirect_to @site
    else
      flash[:error] = "Something went wrong"
      render :create
    end
  end

  def edit
  end

  def update
  end

  protected

  def site_params
    params.require(:site).permit(:name)
  end
end
