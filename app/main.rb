require 'sinatra'
require_relative 'controllers/user_controller'

post '/user/create' do
    UserController.save(user_data)
end
