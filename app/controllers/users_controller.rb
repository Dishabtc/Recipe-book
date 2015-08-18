class UsersController < ApplicationController
  
  def home
    if user_signed_in?
     @categories = Category.all
    else
      render 'home'
      


  end
  end
  def show
    @user = User.find(params[:id])
    @recipes = current_user.recipes.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
