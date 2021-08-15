
class User
    attr_reader :username, :email, :bio

    def initialize(param)
        @username = param[:username]
        @email = param[:email]
        @bio = param[:bio]
    end

    #Validation to prevent nil username and email
    def valid?
        return false if @username.nil? || @email.nil?

        true
    end
end