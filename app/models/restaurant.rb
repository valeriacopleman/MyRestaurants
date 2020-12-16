class Restaurant < ApplicationRecord

  belongs_to :user
  belongs_to :category
  validates :name, presence: true
  validates :category, presence: true
  accepts_nested_attributes_for :category, reject_if: :all_blank
  
  scope :recent, -> { order(created_at: :desc) }

end

