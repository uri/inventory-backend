class Api::CategoriesController < ApplicationController
  respond_to :json

  def index
    @categories = Category.all
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      respond_with @category
    else
      respond_with @category, status: :unprocessable_entity
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      respond_with @category
    else
      respond_with @category, status: :unprocessable_entity
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      head :ok
    else
      head :unprocessable_entity
    end
  end

private

  def category_params
    params.require(:category).permit(:name, :description)
  end

end
