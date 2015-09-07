require 'rails_helper'

RSpec.describe Building, type: :model do
  context "with a blank database" do
  	it "has no buildings" do
  		expect(Building.all.count).to eq(0)
  	end
  end
  context "with 2 buildings" do
  	before do
      bldg1 = Building.create(
	    {
	      "id"=>"011", 
	      "name"=>"Test bldg 1",
	      "lat"=>"44.9768488".to_f,
	      "lng"=>"-93.23709211000001".to_f,
	    }
	  )
	  bldg2 = Building.create(
	    {
	      "id"=>"211", 
	      "name"=>"Test bldg 2",
	      "lat"=>"44.98721406".to_f,
	      "lng"=>"-93.18506407".to_f,
	    }
	  )
  	end

  	it "has 2 buildings" do
  		expect(Building.all.count).to eq(2)
  		expect(Building.find_by({name: "Test bldg 2"}).id).to eq(211)
  	end


  	
  end

end
