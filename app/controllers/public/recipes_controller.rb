class Public::RecipesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @post = Post.find(params[:post_id])
    @recipes = Recipe.all
    @recipe = Recipe.new
    @tag = @recipe.tags.new
  end

  def show
    @recipe = Recipe.find_by(params[:id])
    @tags = Tag.where(recipe_id: @recipe.id)
  end

  def create
    @post = Post.find(params[:post_id])
    @recipe = current_customer.recipes.new(recipe_params)
    @recipe.post_id = @post.id
    @recipe.save
    @recipes = Recipe.all
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
    params.require(:recipe).permit(:recipe_title, :category, :material, :status, :content, tags_attributes: [:content], recipe_images: [])
  end
end
