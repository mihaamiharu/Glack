require_relative '../db/db_connection'
class User
    attr_accessor :username, :email, :bio

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

    #Save user data
    def save
        client = create_db_client
        sql = "INSERT INTO user (username, email, bio) VALUES ('#{username}', '#{email}', '#{bio}')"
        
        client.query(sql)
    end
end