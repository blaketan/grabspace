set :rails_env,  'production'

server 'asr-getaroom-prod1.oit.umn.edu',
       roles: %w(web app db)
