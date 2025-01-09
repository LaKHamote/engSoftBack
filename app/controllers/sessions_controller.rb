class SessionsController < ApplicationController
  def google_auth
    # Lógica para lidar com a autenticação do Google
    user = User.from_omniauth(request.env['omniauth.auth'])
    if user
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Successfully authenticated from Google account.'
    else
      redirect_to root_path, alert: 'Failed to authenticate from Google account.'
    end
  end
end