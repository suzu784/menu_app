class Public::RecipesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @post = Post.find(params[:post_id])
    @recipes = Recipe.published.where(post_id: @post.id)
    @recipe = Recipe.new
    @tag = @recipe.tags.new
    @tags = Tag.where(recipe_id: @recipe.id)
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
    @recipes = Recipe.where(post_id: @post.id)
    @tags = Tag.where(recipe_id: @recipe.id)
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
    @recipe = current_customer.recipes.draft.find_by(params[:post_id])
    @tags = Tag.where(recipe_id: @recipe_id)
  end

  private

  def recipe_params
    params.require(:recipe).permit(:category, :material, :status, :content, tags_attributes: [:content])
  end
  def update_recipe_params
    params.require(:recipe).permit(:id, :category, :material, :status, :content, tags_attributes: [:content])
  end
end
