module Facebook
  def facebook_app_access_token
    if Rails.env.production?
      fb_id = ENV['FACEBOOK_APP_ID_DEV']
      fb_secret = ENV['FACEBOOK_SECRET_DEV']
    else
      fb_id = ENV['FACEBOOK_APP_ID_PROD']
      fb_secret = ENV['FACEBOOK_SECRET_PROD']
    end
    fb_id + '|' + fb_secret
  end

  def fb_graph
    "https://graph.facebook.com/v2.3/"
  end
end