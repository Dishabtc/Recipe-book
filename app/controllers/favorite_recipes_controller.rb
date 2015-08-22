class FavoriteRecipesController < ApplicationController
  before_action :current_user

  def create
    @fav_recipes = current_user.favorite_recipes.build
    @recipe = Recipe.find(params[:recipe_id])
    current_user.favorite_recipes(@recipe)
    
    respond_to do |format|
      format.html { redirect_to @recipe }
      format.js
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @unfav_recipes = current_user.favorite_recipes.find_by(recipe_id: current_user.id)
    current_user.favorite_recipes(@recipe)
    # current_user.favorites.delete(@recipe)
     respond_to do |format|
      format.html { redirect_to @recipe }
      format.js
    end
  end
end
