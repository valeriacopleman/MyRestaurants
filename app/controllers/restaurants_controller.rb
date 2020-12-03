class RestaurantsController < ApplicationController

    def new
        @restaurant = Restaurant.new
    end

    def create
        @restaurant = Restaurant.create(restaurant_params)
    end
    
    private
 
    def restaurant_params
        params.require(:restaurant).permit(:name, :user_id, :category_id)
    end
end
