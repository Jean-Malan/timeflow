json.extract! listing, :id, :name, :cards, :position, :created_at, :updated_at, :client_id, :user_id
json.url listing_url(listing, format: :json)
