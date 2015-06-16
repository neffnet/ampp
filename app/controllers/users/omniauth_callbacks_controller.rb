class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
  
    if @user.persisted?
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
      auth = request.env['omniauth.auth']
      token = auth['credentials']['token']
      session[:fb_access_token] = token

      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end