class RestaurantsController < ApplicationController

    before_action :authenticate_user!

    def index
        if params[:category_id] && @category = current_user.categories.find_by(id: params[:category_id])
            #binding.pry
            @restaurants = current_user.restaurants.where(category_id: @category.id).uniq
        else 
            redirect_to root_path
        end
    end

    def show
        @category = Category.find_by(id: params[:id])
        @restaurant = current_user.restaurants.find_by(id: params[:id])
        if !@category
            redirect_to root_path
        end
    end

    def new
        if params[:category_id] && @category = current_user.categories.find_by(id: params[:category_id])
            @restaurant = @category.restaurants.build
        else
            @restaurant = current_user.restaurants.build
        end
    end

    def create
        if params[:category_id] && @category = current_user.categories.find_by(id: params[:category_id])
            @restaurant = current_user.restaurants.create(restaurant_params)
            if @restaurant.save
                render :show
            else
                render :new
            end
        else
            @restaurant = current_user.restaurants.create(restaurant_params)
            render :show
        end
     
    end

    def edit
        @restaurant = Restaurant.find_by(id: params[:id])
    end

    def update
        @restaurant = Restaurant.find(params[:id])
        @restaurant.update(restaurant_params)
        redirect_to @restaurant
    end

    
    private
 
    def restaurant_params
        params.require(:restaurant).permit(:name, :user_id, :category_id, category_attributes: [
            :name
        ])
    end
end
