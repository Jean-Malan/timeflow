class Card < ApplicationRecord
  acts_as_list 
  scope :sorted, ->{ order(position: :desc) }
  belongs_to :listing
  belongs_to :client
  has_many :time_cards
  has_and_belongs_to_many :tags
  validates :name, presence: true

  def update_attr_on_move(position, listing)
    if listing != nil 
      self.update_attribute(:listing_id, listing.to_i)
      self.save
    end
    if position != nil
      self.insert_at!(position.to_i)
      self.save
    end
    self.save!
  end

end
