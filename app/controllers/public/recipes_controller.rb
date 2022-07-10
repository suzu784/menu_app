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
    if @recipe.status == "draft"
      redirect_to confirm_post_recipes_path(@post)
    else
      redirect_to post_recipe_path(@post, @recipe)
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    @recipe.update
  end

  def confirm
    @post = Post.find(params[:post_id])
    @recipe = current_customer.recipes.draft.find_by(params[:post_id])
  end

  private

  def recipe_params
    params.require(:recipe).permit(:recipe_title, :category, :material, :how_to_make, :status)
  end
end
