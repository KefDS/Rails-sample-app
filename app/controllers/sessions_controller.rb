class SessionsController < ApplicationController
  def new
  end

  def create
    # Información necesaria para logearse
    user = User.find_by(email: params[:session][:email].downcase)
    if user and user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      # sessions es una función de rails que viene con el módulo sessionsHelper
      log_in(user)
      redirect_to user_url(user)
    else
      # Now funciona para que aparezca solo una vez en página con render
      flash.now[:danger] = "Invalid email/password combination"
      render 'new'
    end
  end

  def delete
    log_out
    redirect_to root_url
  end

end
