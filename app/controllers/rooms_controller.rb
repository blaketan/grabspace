class RoomsController < ApplicationController

	def show
		@room = Room.find(params[:id])
		@events = @room.events["start_time"].to_time
		@available = rm_avail(@room.id)
	end
end
