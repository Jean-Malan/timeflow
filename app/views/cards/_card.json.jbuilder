json.extract! card, :id, :listing_id, :card_color, :name, :position, :created_at, :updated_at, :client_id, :user_id, :time_cards, :tag_id
json.url card_url(card, format: :json)
