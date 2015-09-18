require 'open-uri'
require 'json'
require 'openssl'
#OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

buildings = JSON.parse(open("db/json/buildings.json").read)
rooms = JSON.parse(open("db/json/rooms.json").read)

buildings["buildings"].each do |bldg|
  Building.create([
    {
      "id"=>bldg["id"], 
      "name"=>bldg["name"],
      "lat"=>bldg["lat"].to_f,
      "lng"=>bldg["lng"].to_f,
    }
  ])
end

rooms["data"].each do |rm|
  bldg = Building.find_by id: rm[2]
  if bldg.nil?
  	puts "Building #{rm[3]} not found"
  else
    Room.create([
	  {
	    "name"=>rm[1],
	    "capacity"=>rm[4],
	    "building_id"=>rm[2].to_i,
	    "guid"=>rm[0],
 	  }
    ])
  end
end
		

