class Restaurant < ApplicationRecord

  belongs_to :user
  belongs_to :category
  validates :name, presence: true

  accepts_nested_attributes_for :category, reject_if: :all_blank
end
