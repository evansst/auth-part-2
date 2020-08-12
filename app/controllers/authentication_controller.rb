class AuthenticationController < ApplicationController

  def login
    @user = User.find_by(username: params[:username])

    if !@user
      render json: { error: 'Wrong username!' }, status: :unauthorized
    elsif !@user.authenticate(params[:password])
      render json: { error: 'Wrond password!' }, status: :unauthorized
    else
      token = JWT.encode(
        { user_id: @user.id },
        'Literally anything'
      )

      render json: { token: token }
    end
  end
end
