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
  task :events do
    astra_root = "***REMOVED***"
    username = "***REMOVED***"
    ***REMOVED*** = "***REMOVED***"

    params = {}
    params[:fields] = "Location.Room.Building.Name,BuildingCode,RoomNumber,StartDateTime,EndDateTime,Location.MeetingCapacity"

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
    agent.post("#{astra_root}Logon.ashx", "{\"username\": \"#{username}\",\"***REMOVED***\": \"#{***REMOVED***}\"}", 'Content-Type' => 'application/json')
    # Query Astra Calendar room events
    response_body = agent.get("#{astra_root}~api/calendar/calendarList", params).body

    room_events = JSON.parse(response_body)
    fname = "events" + today + ".json"
    target = open('db/json/' + fname, 'w')
    target.puts response_body
    target.close
  end

  task :update => :environment do
    today = Time.now.strftime("%Y-%m-%d")
    fname = "events" + today + ".json"
    rm_events = JSON.parse(open("db/json/" + fname).read)
    rm_events["data"].each do |event|
        rm= Room.find_by building_id: event[1], name: event[2]
        if rm==nil
            rm=Room.create([
                {
                    "name"=>event[2],
                    "capacity"=>event[5].to_i,
                    "building_id"=>event[1].to_i
                }
            ])
        end
        Event.create([
            {
                "start_time"=>event[3],
                "end_time"=>event[4],
                "room_id"=>event[2],
            }
        ])
    end
  end
end