class BuildingsController < ApplicationController
  helper :all
  def index
    @lat_lng = cookies[:lat_lng] ? cookies[:lat_lng].split("|") : false
    if @lat_lng
      @buildings = Building.near(@lat_lng, 20, :order => "distance")
    else
      @buildings = Building.all  
    end
  end

  def show
    @hall = Building.find(params[:id])
    @rooms = @hall.rooms
  end
end
