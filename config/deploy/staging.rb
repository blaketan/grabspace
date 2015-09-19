set :rails_env,  'staging'

server 'asr-getaroom-stage1.oit.umn.edu',
       roles: %w(web app db)
