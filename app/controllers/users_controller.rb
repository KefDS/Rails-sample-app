class UsersController < ApplicationController
  def new
    @user = User.new # Crea un nuevo usuario, que se llanará con los datos del form
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!" # Banners que salen por un periodo de tiempo
      redirect_to user_url(@user)
    else
      render 'new' # Vuelve a el formulario
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
    def user_params
      # Strong params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
