require 'open-uri'
require 'json'
require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

buildings = JSON.parse(open("db/json/available_rooms.json").read)

buildings["buildings"].each do |bldg|
	current_building = bldg["id"]
  Building.create([
    {
      "id"=>bldg["id"], 
      "name"=>bldg["name"],
      "lat"=>bldg["lat"].to_f,
      "lng"=>bldg["lng"].to_f,
    }
  ])
 	bldg["rooms"].each do |rm|
  		Room.create([
  		  {
  		    "id"=>rm["id"],
  		    "name"=>rm["room_number"],
  		    "capacity"=>rm["max_occupancy"],
  		    "building_id"=>current_building,
  		  }
  		])
  	end

  
end

events = JSON.parse(open("db/json/roomevents.json").read)

events.each do |event|
  Event.create([
    {
      "start_time"=>event["start_time"],
      "end_time"=>event["end_time"],
      "room_id"=>event["room_id"],
    }
  ])
  
end
