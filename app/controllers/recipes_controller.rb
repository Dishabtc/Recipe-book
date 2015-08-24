class RecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: :destroy
  

  def favorite
     @recipe = Recipe.find(params[:id])
      type = params[:type]
      if type == "favorite"
        @recipe1 = current_user.favorite_recipes.build(recipe_id: params[:id])
        @recipe1.save
        redirect_to :back
        flash[:success] = "You favorited #{@recipe.name}"

      elsif type == "unfavorite"
        current_user.favorites.delete(@recipe)
        redirect_to :back 
        flash[:danger] = "Unfavorited #{@recipe.name}"

      else
        redirect_to :back
        flash[:info] = 'Nothing happened.'
      end
    end
    
    
  #   if params[:type] == "favorite"
  #     @recipe = Recipe.find(params[:id])
  #     @recipes = current_user.favorites.build
  #     # puts "============================#{@recipe.inspect}"
  #     @recipes.save
  #     # recipe = @recipe.update_attributes(params[:id])

  #     redirect_to :back, notice: 'You Favorited #{@recipe.name}'

  #   elsif type == "unfavorite"
  #     current_user.favorite_recipes.delete(@recipe)
  #     redirect_to :back, notice: 'Unfavorited #{@recipe.name}'

  #   else
  #     redirect_to :back, notice: 'Nothing happened.'
  #   end
  # end


  def index
    if params[:r].present?
      @recipes = Recipe.where('name like ?', "%#{params[:r]}%").paginate(page: params[:page], per_page: 1)
    elsif params[:tag].present?
      @recipes = Recipe.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 1)
    else
      @recipes = Recipe.all.paginate(page: params[:page], per_page: 1)
    end
    @categories = Category.all
    @favorite_recipe = current_user.favorites
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
    @recipe = Recipe.find(params[:id])
    @favorite_recipe = current_user.favorites.paginate(page: params[:page], per_page: 1)
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
      params.require(:recipe).permit(:name, :category_id, :ingredients, :method, :tag_list, :picture)
    end

    def correct_user
      @recipe = current_user.recipes.find_by(id: params[:id])
      redirect_to root_url if @recipe.nil?
    end
end


