class CategoriesController < ApplicationController

    before_action :authenticate_user!
    
    def new
        @category = Category.new
    end

    def create 
        @category = Category.create(params[:name])
    end
end
