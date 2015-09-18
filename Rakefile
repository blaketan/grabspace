# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'mechanize'
require 'open-uri'
require 'json'
require 'openssl'

Grabspace::Application.load_tasks

namespace :astra do
  desc "Extract events from Astra Schedule"
    task :nightly => :environment do 
    Event.destroy_all(['created_at < ?',3.days.ago])
    astra_root = ENV['ASTRA_ROOT']
    username = ENV['ASTRA_ID']
    password = ENV['ASTRA_PASS']

    params = {}
    params[:fields] = "Location.Room.Id,BuildingCode,RoomNumber,StartDateTime,EndDateTime,Location.MeetingCapacity"

    today = Time.now.strftime("%Y-%m-%d")

    params[:filter] = ""
    # Filter to only today's scheduled events
    params[:filter] << "(StartDate>='#{today.to_s}T00:00:00')"
    params[:filter] << "&&(EndDate<='#{today.to_s}T23:59:00')"
    # Filter to only General Purpose Classrooms on the Twin Cities campus
    params[:filter] << "&&(Location.Room.Building.Campus.Name=='Mpls/StPaul')"
    params[:filter] << "&&(Location.Room.RoomType.Name=='General Purpose Classroom')"
    # Filter out potential Astra Schedule soft deletes
    params[:filter] << "&&(Location.IsDeleted!=1)"
    params[:filter] << "&&(Location.Room.IsDeleted!=1)"
    params[:filter] << "&&(Location.Room.Building.IsDeleted!=1)"
    params[:filter] << "&&(Location.Room.Building.Campus.IsDeleted!=1)"
    params[:filter] << "&&(Location.Room.RoomType.IsDeleted!=1)"

    agent = Mechanize.new
    # Authenticate with Astra Calendar API
    agent.post("#{astra_root}Logon.ashx", "{\"username\": \"#{username}\",\"password\": \"#{password}\"}", 'Content-Type' => 'application/json')
    # Query Astra Calendar room events
    puts params
    response_body = agent.get("#{astra_root}~api/calendar/calendarList", params).body

    File.open("db/json/events" + today + ".json","w") do |f|
      f.write(response_body)
    end

    room_events = JSON.parse(response_body)

    room_events["data"].each do |event|
      rm= Room.find_by guid: event[0]
      if rm.nil?
        puts "Room #{event[2]} of #{event[1]} not found"
      else
        Event.create([
          {
            "start_time"=>event[3].to_time,
            "end_time"=>event[4].to_time,
            "room_id"=>rm[:id]
          }
      ])
      end
    end

  end

  task :make_room_seed => :environment do 
    astra_root = ENV['ASTRA_ROOT']
    username = ENV['ASTRA_ID']
    password = ENV['ASTRA_PASS']

    params = {}
    params[:fields] = "Id,RoomNumber,Building.BuildingCode,Building.Name,MaxOccupancy"
    params[:filter] = ""

    # Filter to only General Purpose Classrooms on the Twin Cities campus
    params[:filter] << "(Building.Campus.Name=='Mpls/StPaul')"
    params[:filter] << "&&(RoomType.Name=='General Purpose Classroom')"
    # Filter out potential Astra Schedule soft deletes
    params[:filter] << "&&(IsDeleted!=1)"
    params[:filter] << "&&(Building.IsDeleted!=1)"
    params[:filter] << "&&(Building.Campus.IsDeleted!=1)"
    params[:filter] << "&&(RoomType.IsDeleted!=1)"

    agent = Mechanize.new
    # Authenticate with Astra Calendar API
    agent.post("#{astra_root}Logon.ashx", "{\"username\": \"#{username}\",\"password\": \"#{password}\"}", 'Content-Type' => 'application/json')
    # Query Astra Calendar rooms
    response_body = agent.get("#{astra_root}~api/query/room", params).body

    File.open("db/json/rooms.json","w") do |f|
      f.write(response_body)
    end
  end
end