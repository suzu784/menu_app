class Public::RecipesController < ApplicationController
  before_action :authenticate_customer!

  def new
    @post = Post.find(params[:post_id])
    @recipe = Recipe.new
    @tag = @recipe.tags.new
  end

  def show
    @recipe = Recipe.find(params[:id])
    @tags = Tag.where(recipe_id: @recipe.id)
  end

  def create
    @post = Post.find(params[:post_id])
    @recipe = current_customer.recipes.new(recipe_params)
    @recipe.post_id = @post.id
    if @recipe.save
      redirect_to post_recipe_path(@post, @recipe)
    else
      flash[notice] = "工程を入力してください"
      render :new
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
    params.require(:recipe).permit(:recipe_title, :category, :material, :status, :content, tags_attributes: [:content], recipe_images: [])
  end
end
