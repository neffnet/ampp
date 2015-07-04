class SitesController < ApplicationController
  include Facebook

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

    FbGraph2.api_version = 'v2.3'
    @fb_page = FbGraph2::Page.new(@site.facebook_page_id, access_token: facebook_app_access_token).fetch
    all_events = @fb_page.events.sort_by{|e| e.start_time}
    events = all_events.find_all{|e| e.start_time >= Time.now}

    @events = events.map { |e| FacebookEvent.new(e.id) }
  end

  protected

  def site_params
    params.require(:site).permit(:name, :facebook_page_id)
  end

end
