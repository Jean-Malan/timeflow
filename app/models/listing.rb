class Listing < ApplicationRecord
  acts_as_list
  has_many :cards, ->{ order(position: :desc) }, dependent: :destroy
  scope :sorted, ->{ order(position: :asc) }
  validates :name, presence: true
  has_many :time_cards, through: :cards


  def create_listing(list_position, list_name, list_user)
    position = list_position
    name = list_name
    user_id = list_user
  end

end


