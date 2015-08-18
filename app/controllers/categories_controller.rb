class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: :destroy

  def index
     @categories = Category.all
  end


  def show
    @category = Category.find(params[:id])
    @recipes = @category.recipes

  end 




  
end
