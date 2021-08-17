require_relative '../db/db_connection'
class User
    attr_accessor :username, :email, :bio

  def initialize(param)
      @username = param[:username]
      @email = param[:email]
      @bio = param[:bio]
  end

  def valid?
      return false if @username.nil? || @email.nil?

      true
  end

  def save
      client = create_db_client
      sql = "INSERT INTO user (username, email, bio) VALUES ('#{username}', '#{email}', '#{bio}')"
        
      client.query(sql)
  end
end