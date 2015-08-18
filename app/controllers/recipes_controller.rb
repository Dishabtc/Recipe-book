class RecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: :destroy

  def index
    @recipes = Recipe.all
    @categories = Category.all
    
    
  end
  
  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      flash[:success] = "Recipe created!"
     redirect_to root_url
    else
      @feed_items = []
      flash[:danger] = "Fill All field"
      render "new"
    end
  end

  def destroy
    @recipe.destroy
    flash[:success] = "Recipe deleted"
    redirect_to request.referrer || user_path(current_user)
  end

  def show
    @recipes = current_user.recipes 
    
    

  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
  @recipe = Recipe.find(params[:id])
  if @recipe.update_attributes(recipe_params)
    flash[:success] = "profile Updated"
    redirect_to @recipe
    #handle a successful update. 
  else
    render 'edit'
  end
  end

  private

    def recipe_params
      params.require(:recipe).permit(:name, :category_id, :ingredients, :method, :picture)
    end

    def correct_user
      @recipe = current_user.recipes.find_by(id: params[:id])
      redirect_to root_url if @recipe.nil?
    end
end


