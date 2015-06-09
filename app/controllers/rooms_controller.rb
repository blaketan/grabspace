class RoomsController < ApplicationController

	def show
		@room = Room.find(params[:id])
		@events = @room.events.sort
		@available = [@room.available?,@room.next_timing]
	end
end
