class CategoriesController < ApplicationController

    before_action :authenticate_user!
    
    def index
        @categories = current_user.categories.all
    end

    def show
        @category = current_user.categories.find_by(id: params[:id])
        if !@category
            redirect_to root_path
        end
    end
    
    def new 
        @category = Category.new
        @restaurant = @category.restaurants.build
    end

    def create 
        category = Category.find_by(name: category_params[:name])
        if !category
            category = current_user.categories.create(category_params)
        end
        redirect_to category
        binding.pry
    end

    def destroy
        @restaurants = Restaurant.where(category_id: params[:category.id])
        @restaurants.each do |restaurant|
            restaurant.destroy
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

