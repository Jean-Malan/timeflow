json.extract! client, :id, :name, :address, :created_at, :updated_at, :time_cards
json.url client_url(client, format: :json)
