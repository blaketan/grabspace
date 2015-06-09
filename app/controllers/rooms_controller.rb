class RoomsController < ApplicationController

  def show
	@room = Room.find(params[:id])
	@hall = Building.find_by(id: @room[:building_id])
	@events = @room.events.sort
	@available = [@room.available?,@room.next_timing]
	end
end
