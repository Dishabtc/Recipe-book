class UsersController < ApplicationController
  require 'will_paginate/array'
  
  def home
    if user_signed_in?
     @categories = Category.all
     @recipes = Recipe.all
    else
      render 'home'
  end
  end
  def show
    @user = User.find(params[:id])
    @recipes = current_user.recipes.paginate(page: params[:page], per_page: 1)
     @favorite_recipe = current_user.favorites.paginate(page: params[:page], per_page: 1)
     @like_recipe = current_user.find_liked_items.paginate(page: params[:page], per_page: 1)
   end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params.merge!(role_id:1))
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
