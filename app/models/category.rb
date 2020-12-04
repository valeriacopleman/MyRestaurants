class Category < ApplicationRecord
    has_many :restaurants
    has_many :users, through: :restaurants
end
