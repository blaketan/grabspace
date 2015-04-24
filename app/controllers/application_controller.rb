class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  	def rm_avail(room)
		offset = 60*60*5
  		t = Time.now
  		rmevents = Event.where(room_id: room).today.load
  		puts "Room events today : #{rmevents.count}"
		available = true
		next_timing = Time.new(t.year,t.month,t.day,22)
		if t.hour < 7 
			available = false
			next_timing = Time.new(t.year,t.month,t.day,7)
		elsif t.hour >21
			available = false
			next_timing = Time.new(t.year,t.month,t.day,7)	
		else
			for i in 0..(rmevents.count - 1)
				if t >= (rmevents[i][:start_time].to_time+offset) and t < (rmevents[i][:end_time].to_time+offset)
					available = false
					next_timing = (rmevents[i][:end_time].to_time+offset)
					break
				elsif t < (rmevents[i][:start_time].to_time+offset) and t > (rmevents[i-1][:end_time].to_time+offset)
					next_timing = (rmevents[i][:start_time].to_time+offset)
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
