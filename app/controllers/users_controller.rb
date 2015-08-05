class UsersController < ApplicationController
  # Se ejecuta antes de llamar a todos los métodos o métodos descritos en only:
  before_action :logged_in_user, only:  [:index, :edit, :update]
  before_action :correct_user, only:    [:edit, :update]

  def index
    #@users = User.all
    @users = User.page(params[:page])
  end

  def new
    @user = User.new # Crea un nuevo usuario, que se llanará con los datos del form
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user) # Inicia la sessión inmediatamente
      flash[:success] = "Welcome to the Sample App!"
      redirect_to user_url(@user)
    else
      render 'new' # Vuelve a el formulario
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # successful update
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
    def user_params
      # Strong params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # Before filters

    # Confirms a loogged_in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirm the correct user
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

end
