require 'rails_helper'

RSpec.describe Room, type: :model do
  context "With 2 rooms" do
    before do
      new_time = Time.zone.local(2015,1,1,12,0,0)
      Timecop.freeze(new_time)
      rm1 = Room.create({
      	"name"=> "123a",
      	"capacity"=>30,
      	"building_id" => 1
      	})
      rm2 = Room.create({
      	"name"=> "123b",
      	"capacity"=>90,
      	"building_id" => 1
      	})
      evt1 = Event.create({
      	"start_time"=>new_time-2*60*60,
      	"end_time"=>new_time - 60*60,
      	"room_id" => rm1[:id]
      	})
      evt2 = Event.create({
      	"start_time"=>new_time-60,
      	"end_time"=>new_time + 60*60,
      	"room_id" => rm2[:id]
      	})
  	end

  	after do
  	  Timecop.return
  	end

  	it "is not closed" do
  	  expect(Room.building_closed?).to eq(false)
  	end

  	it "has one available room" do
  	  expect(Room.available.count).to eq(1)
  	  expect(Room.available.first[:name]).to eq("123a")
  	end
  	it "has one unavailable room" do
  	  expect(Room.unavailable.count).to eq(1)
  	  expect(Room.unavailable.first[:name]).to eq("123b")
  	end

  	it "available room has next_timing at end of day" do
      end_of_day = Time.zone.now.beginning_of_day + 22*60*60
  	  expect(Room.available.first.next_timing).to eq(end_of_day)
  	end

  	it "unavailable room has next_timing at end of event" do
   	  end_time = Time.zone.local(2015,1,1,13,0,0)
   	  expect(Room.unavailable.first.next_timing).to eq(end_time)	  
  	end
  	it "is not available on a saturday" do
  	  expect(Room.building_closed?(Time.zone.local(2015,1,3,12,0,0))).to eq(true)
    end
  end
end
