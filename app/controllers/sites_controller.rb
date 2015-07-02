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

  def edit
    @site = Site.find(params[:id])
  end

  def update
    @site = Site.find(params[:id])
    if @site.update_attributes(site_params)
      flash[:notice] = "#{@site.name} site updated successfully"
      redirect_to @site
    else
      flash[:error] = "Something went wrong. Please try again."
      render :edit
    end
  end

  def show
    @site = Site.find(params[:id])

    if Rails.env.production?
      fb_id = ENV['FACEBOOK_APP_ID_DEV']
      fb_secret = ENV['FACEBOOK_SECRET_DEV']
    else
      fb_id = ENV['FACEBOOK_APP_ID_PROD']
      fb_secret = ENV['FACEBOOK_SECRET_PROD']
    end

    auth = FbGraph2::Auth.new(fb_id, fb_secret, api_version: 2.2)
    @fb_page = FbGraph2::Page.new(@site.facebook_page_id, access_token: auth.access_token!).fetch
  
    all_events = @fb_page.events.sort_by{|e| e.start_time}
    @events = all_events.find_all{|e| e.start_time >= Time.now}
  end

  protected

  def site_params
    params.require(:site).permit(:name, :facebook_page_id)
  end
end
