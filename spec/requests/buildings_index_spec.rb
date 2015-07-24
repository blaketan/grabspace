require 'rails_helper'

RSpec.describe "Building", type: :request do
  before(:each) do
    load "#{Rails.root}/db/seeds.rb"
  end

  describe "GET buildings#index" do
    it "works! (now write some real specs)" do
      get buildings_path
      expect(response).to have_http_status(200)
    end
  end
end
