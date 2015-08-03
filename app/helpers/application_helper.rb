module ApplicationHelper

  def site_path(site)
    "/#{site.slug}"
  end
end
