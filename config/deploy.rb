lock '3.4.0'

set :application, 'grabspace'
set :repo_url, 'git@github.com:umn-asr/grabspace.git'

ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

set :deploy_to, '/swadm/www/getaroom.umn.edu'

set :user, 'swadm'

set :passenger_restart_with_touch, true

set :ssh_options,
    user: fetch(:user),
    forward_agent: true,
    auth_methods: %w(publickey)

set :linked_files,
    fetch(:linked_files, []).push('config/initializers/environment_variables.rb'
    						      'db/json/buildings.json')

set :linked_dirs,
    fetch(:linked_dirs, []).push('log',
                                 'tmp/cache',
                                 'vendor/bundle')
