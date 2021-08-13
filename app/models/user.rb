
class User
    attr_reader :username, :email, :bio

    def initialize(param)
        @username = param[:username]
        @email = param[:email]
        @bio = param[:bio]
    end

end