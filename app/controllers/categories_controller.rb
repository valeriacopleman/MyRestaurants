class CategoriesController < ApplicationController

    before_action :authenticate_user!
    
    def index
        @categories = current_user.categories.all
    end

    def show
        @category = Category.find_by(id: params[:id])
    end
    
    def new 
        @category = Category.new
        @restaurant = @category.restaurants.build
    end

    def create 
        category = Category.find_by(name: category_params[:name])
        if !category
            category = Category.create[category_params]
        end
        redirect_to category
    end

    private

    def category_params
        params.require(:category).permit(
            :name,
            restaurants_attributes: [
                :name
            ]
        )
    end

end

