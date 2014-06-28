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

private

  def category_params
    params.require(:category).permit(:name, :description)
  end

end
