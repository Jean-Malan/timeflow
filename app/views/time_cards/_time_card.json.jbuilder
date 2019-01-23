json.extract! time_card, :id, :total_time, :recorded_time, :card, :description, :time, :date, :client_id, :card_id, :tag_id, :created_at, :updated_at
json.url time_card_url(time_card, format: :json)
