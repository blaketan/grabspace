module BuildingsHelper
	def rm_free(room)
  		rmevents = Event.where(room_id: room).all
		cur_time = Time.now.strftime("%H%M").to_i
		available = true
		next_timing = 2200

		if cur_time < 700 or cur_time >2200
			available = false
			next_timing = 700
		elsif rmevents.count == 0
			available = true
		else
			for i in 0..(rmevents.count -1)
				if cur_time >= rmevents[i][:start_time] and cur_time < rmevents[i][:end_time]
					available = false
					next_timing = rmevents[i][:end_time]
					break
				elsif cur_time < rmevents[i][:start_time] and cur_time > rmevents[i-1][:end_time]
					next_timing = rmevents[i][:start_time]
					break
				end
			end
		end

		case available
		when false
			return [false,next_timing] 
		when true
			return [true, next_timing]
		end

	end

	def availcount(building)
		count = 0
		rms = Room.where(building_id: building).all
		rms.each do |x|
			if rm_free(x.id)[0] == true
				count += 1
			end
		end
		return count
	end

  def compass(building, lat_lng)
    Geocoder::Calculations.compass_point(building.bearing_from(lat_lng)) 
  end
end
