class Client < ApplicationRecord
    has_many :time_cards
    has_many :cards
end
