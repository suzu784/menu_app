class Public::RecipesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @post = Post.find(params[:post_id])
    @recipes = Recipe.published.where(post_id: @post.id)
    @recipe = Recipe.new
  end

  def create
    @post = Post.find(params[:post_id])
    if params[:recipe][:id] != nil
      @recipe = Recipe.find(params[:recipe][:id])
      @recipe.update(update_recipe_params)
    else
      @recipe = current_customer.recipes.new(recipe_params)
      @recipe.post_id = @post.id
      @recipe.save
    end
    @recipes = Recipe.where(post_id: @post.id ,status: 0)
    respond_to do |format|
      format.html { redirect_to post_recipes_path }
      format.js {}
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    if @recipe.destroy
      redirect_to post_recipes_path
    else
      render :index
    end
  end

  def confirm
    @post = Post.find(params[:post_id])
    @recipe = @post.recipes.find_by(status: :draft)
  end

  private

  def recipe_params
    params.require(:recipe).permit(:recipe_image, :status, :content)
  end
  def update_recipe_params
    params.require(:recipe).permit(:id, :recipe_image, :status, :content)
  end
end
