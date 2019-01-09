class TimeCard < ApplicationRecord
	belongs_to :card
	has_many :tags
	belongs_to :client

	def create_time_card(client, card, time_start, time_end, time)
		client != "" ? client_id = client : client_id = ""
		card != "" ? card_id = card : card_id = ""
		time_start != "" ? start_time = time_start : start_time = ""
		time_end != "" ? end_time = time_end : end_time = ""
		time != "" ? time = client : time = ""
	end
 
  def format_time(time)
    t = time.to_i
    Time.at(t).utc.strftime("%H:%M:%S")
  end


end
