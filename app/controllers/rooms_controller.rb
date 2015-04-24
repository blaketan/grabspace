class RoomsController < ApplicationController

	def show
		@room = Room.find(params[:id])
		@event = @room.events
		@events = @event["start_time"]
		@available = rm_avail(@room.id)
	end
end
