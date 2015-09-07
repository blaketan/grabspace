# GrabSpace

##Setup
1. Clone the repo
2. The project is initially configured to run on an Oracle DB. Replace the gems the 'Gemfile' if using another DB.
3. Setup the following files:
  - config/database.yml
  - db/json/buildings.json
4. Set up the '.env' file in the root folder with the following details:
  - ASTRA_ID
  - ASTRA_PASS
  - ASTRA_ROOT
  - GMAPS_KEY
  - SECRET_KEY_BASE
5. Run the following commands
  - 'bundle install'
  - 'rake db:schema:load'
  - 'rake db:seed'

## Testing

- `./bin/rspec`
