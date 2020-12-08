class CategoriesController < ApplicationController

    before_action :authenticate_user!
    
    def index
        @categories = current_user.categories.uniq
        
    end
    
    def new 
        @category = Category.new
        @restaurant = @category.restaurants.build
    end

    def create 
        category = Category.find_by(name: params[:name])
        if !category
            category = current_user.categories.create(category_params)
        end
       
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

