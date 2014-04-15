class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  	def rm_avail(rmevents)
		cur_time = Time.now.strftime("%I%M").to_i
		available = true
		next_timing = 2200
		if cur_time < 700 or cur_time >2200 or rmevents.count == 0
			available = false
			next_timing = 700
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
end
