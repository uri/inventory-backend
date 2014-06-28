module Api
  class CategoriesController < ApplicationController
    respond_to :json

    # POST 
    def create
      @category = Category.new(category_params)
      if category.save
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

end