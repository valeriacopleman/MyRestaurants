class CategoriesController < ApplicationController

    before_action :authenticate_user!

    def index
        @categories = current_user.categories.all
    end
    
    def new
        @category = Category.new
        @restaurant = @category.books.build
    end

    def create 
        Category.find_by(name: category_params[:name])
        if !category
            category = Category.create[author_params]
        end
        redirect_to category
    end

    private

    def category_params
        params.require(:restaurant).permit(
            :name,
            restaurant_attributes[
                :name
            ]
        )
    end

end

