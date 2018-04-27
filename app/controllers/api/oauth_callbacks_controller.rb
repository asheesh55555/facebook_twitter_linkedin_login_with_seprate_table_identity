class Api::OauthCallbacksController < ActionController::Base
  def facebook
    
    handle_social_login(oauth_params)
  end

  def google
    handle_social_login(oauth_params)
  end

  def twitter
    handle_social_login(oauth_params)
  end

  def handle_social_login oauth_params
 	  data = { provider: oauth_params[:provider], uid: oauth_params[:uid], new_email: true,
 	  	info: { email: oauth_params[:email], name: oauth_params[:username], first_name: oauth_params[:first_name], last_name: oauth_params[:last_name] } }
	  auth_data = JSON.parse(data.to_json, object_class:OpenStruct)
	  auth 	= Identity.format_data(auth_data)
    oauth = Identity.find_for(auth)
	  oauthDate = Identity.find_and_init_for(auth)
	  if oauthDate.user.present?
	    render json: {user: oauthDate.user, message: "Successfully logged in by #{oauth_params[:provider]}", status: 'success'}, :status => 200
	  else
	    render json: {message: 'Login faild', status: 'failed' }, :status => 401
	  end
  end

  private

  def oauth_params
    params.permit(:email, :first_name, :last_name, :username, :uid, :provider )
  end

end
