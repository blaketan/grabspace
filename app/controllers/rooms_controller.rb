class RoomsController < ApplicationController

	def show
		@room = Room.find(params[:id])
		@events = @room.events.sort
		@available = rm_avail(@events)
	end
end
