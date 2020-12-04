class RestaurantsController < ApplicationController

    before_action :authenticate_user!

    def index
        @restaurants = Restaurant.all
    end

    def new
        @restaurant = Restaurant.new
    end

    def create
        #binding.pry
        @restaurant = current_user.restaurants.build(restaurant_params)
        if @restaurant.save
            redirect_to restaurants_path
        else 
            render :new
        end
    end


    
    private
 
    def restaurant_params
        params.require(:restaurant).permit(:name, :user_id, :category_id, category_attributes: [
            :name
        ])
    end
end
