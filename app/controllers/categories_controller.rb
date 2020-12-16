class CategoriesController < ApplicationController

    before_action :authenticate_user!
    
    def index
        @categories = current_user.categories.uniq
        
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

