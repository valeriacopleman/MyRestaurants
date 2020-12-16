class RestaurantsController < ApplicationController

    before_action :authenticate_user!

    def index
        if params[:category_id] && @category = current_user.categories.find_by(id: params[:category_id])
            @restaurants = current_user.restaurants.where(category_id: @category.id).uniq
        else 
            redirect_to root_path
        end
    end

    def show
        @category = Category.find_by(id: params[:id])
        @restaurant = current_user.restaurants.find_by(id: params[:id])
        if !@category || !@restaurant
            redirect_to root_path
        else 
            render 'restaurants/show'
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
                render 'restaurants/show'
            
            else
                render :new
            end
        else
            @restaurant = current_user.restaurants.create(restaurant_params)
            if @restaurant.save
                render 'restaurants/show'
            else
                render :new
            end
        end 
    end

    def edit
        @restaurant = current_user.restaurants.find_by(id: params[:id])
        @category = Category.find_by(id: params[:id])
        if !@restaurant
            redirect_to root_path
        end
    end

    def update
        @restaurant = Restaurant.find(params[:id])
        if !params[:restaurant][:name].empty? && !params[:restaurant][:category_id].empty?
            @restaurant.update(restaurant_params)
            render 'restaurants/show'
        else
            flash.now[:notice] = "Error"
            redirect_to edit_restaurant_path
        end
    end

    
    private
 
    def restaurant_params
        params.require(:restaurant).permit(:name, :user_id, :category_id, category_attributes: [
            :name
        ])
    end
end
