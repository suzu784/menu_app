class Public::RecipesController < ApplicationController
  before_action :authenticate_customer!

  def new
    @post = Post.find(params[:post_id])
    @recipe = Recipe.new
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def create
    @post = Post.find(params[:post_id])
    @recipe = current_customer.recipes.new(recipe_params)
    @recipe.post_id = @post.id
    @recipe.save
    redirect_to post_recipe_path(@post, @recipe)
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    @recipe.update
  end

  private

  def recipe_params
    params.require(:recipe).permit(:recipe_title, :category, :material, :how_to_make)
  end
end
