require_relative '../models/user'

class UserController
    def self.save(user_data)
        user = User.new(user_data)
        user.save
    end

    def self.find_user(username) 
        User.find_user(username)
    end
end