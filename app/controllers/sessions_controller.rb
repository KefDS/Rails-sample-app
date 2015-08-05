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
      # Crea o no token de autorización, esta función se encuetra en sessions_helper
      params[:session][:remember_me] == '1' ? remember(user) : forget(user) # Checkbox
      redirect_back_or user
    else
      # Now funciona para que aparezca solo una vez en página con render
      flash.now[:danger] = "Invalid email/password combination"
      render 'new'
    end
  end

  def delete
    log_out if logged_in?
    redirect_to root_url
  end

end
