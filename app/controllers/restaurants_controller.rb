class RestaurantsController < ApplicationController

    before_action :authenticate_user!

    def index
        if params[:category_id] && @category = Category.find_by(id: params[:category_id])
            @restaurant = @category.restaurants 
        else 
            @restaurants = Restaurant.all
        end
    end

    def show
        @restaurant = current_user.restaurants.find_by(id: params[:id])
        if !@restaurant
            redirect_to category_path
        end

    end

    def new
        if params[:category_id] && @category = Category.find_by(id: params[:category_id])
            @restaurant = @category.restaurants.build
        else
            @restaurant = Restaurant.new
        end
    end

    def create
        if params[:category_id] && @category = Category.find_by(id: params[:category_id])
            @restaurant = current_user.restaurants.build(restaurant_params)
            if @restaurant.save
                redirect_to category_restaurants_path
            else
                render :new
            end
        end
    end

    def edit
        @restaurant = Restaurant.find_by(id: params[:id])
    end

    def update
        @restaurant = Restaurant.find(params[:id])
        @restaurant.update(restaurant_params)
        redirect_to restaurant_path(@restaurant)
    end

    def destroy
        @restaurant.destroy
        redirect_to root_path
    end


    
    private
 
    def restaurant_params
        params.require(:restaurant).permit(:name, :user_id, :category_id, category_attributes: [
            :name
        ])
    end
end
