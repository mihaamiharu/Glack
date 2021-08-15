require_relative '../models/user'

class UserController
    def self.save(user_data)
        user = User.new(user_data)
        user.save
    end
end