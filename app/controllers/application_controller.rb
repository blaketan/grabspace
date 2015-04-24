class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  	def rm_avail(room)
  		t = Time.now
  		rmevents = Event.today.where(room_id: room).load
		available = true
		next_timing = Time.new(t.year,t.month,t.day,22)
		if t.hour < 7 
			available = false
			next_timing = Time.new(t.year,t.month,t.day,7)
		elsif t.hour >22
			next_timing = Time.new(t.year,t.month,t.day,7)+(60*60*24)	
		else
			for i in 0..(rmevents.count-1)
				if t >= rmevents[i][:start_time].to_time and t < rmevents[i][:end_time].to_time
					available = false
					next_timing = rmevents[i][:end_time].to_time
					break
				elsif t < rmevents[i][:start_time].to_time and t > rmevents[i-1][:end_time].to_time
					next_timing = rmevents[i][:start_time].to_time
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
