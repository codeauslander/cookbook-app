class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
    search = params[:search]
    sort = params[:sort]
    if search
      @recipes = @recipes.where("title iLIKE ? OR ingredients iLIKE ?",
      "%#{search}%",
      "%#{search}%")
    end    
    if sort
      @recipes = @recipes.order(sort => :asc)
    end
    render 'index.json.jbuilder'
  end 
  def create
    @recipe = Recipe.new(
        title:params[:title],
        chef:params[:chef],
        ingredients:params[:ingredients],
        directions:params[:directions]
      )
    @recipe.save
    render json:@recipe.as_json
  end
  def show
    @recipe = Recipe.find(params[:id])
    render 'show.json.jbuilder'
  end
  def update
    @recipe = Recipe.find(params[:id])
    @recipe.title = params[:title] || @recipe.title
    @recipe.chef = params[:chef] || @recipe.chef
    @recipe.ingredients = params[:ingredients] || @recipe.ingredients
    @recipe.directions = params[:directions] || @recipe.directions
    @recipe.save
    render json:@recipe.as_json
  end
  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    render json: { message: "Succefully destroyed Recipe ##{@recipe.id}."}
  end
end
