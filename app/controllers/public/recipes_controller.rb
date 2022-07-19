class Public::RecipesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @post = Post.find(params[:post_id])
    @recipes = Recipe.where(post_id: @post.id)
    @recipe = Recipe.new
    @tag = @recipe.tags.new
    @tags = Tag.where(recipe_id: @recipe.id)
  end

  def create
    @post = Post.find(params[:post_id])
    @recipe = current_customer.recipes.new(recipe_params)
    @recipe.post_id = @post.id
    @recipe.save
    @recipes = Recipe.where(post_id: @post.id)
  end

  def confirm
    @post = Post.find(params[:post_id])
    @recipe = current_customer.recipes.draft.find_by(params[:post_id])
  end

  private

  def recipe_params
    params.require(:recipe).permit(:category, :material, :status, :content, tags_attributes: [:content], recipe_images: [])
  end
end
