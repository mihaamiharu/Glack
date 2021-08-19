require_relative '../db/db_connection'
require 'json'

class User
    attr_accessor :username, :email, :bio

  def initialize(param)
      @username = param[:username]
      @email = param[:email]
      @bio = param[:bio]
  end

  def valid?
      return false if @username.nil? || @email.nil? || is_a_valid_email?

      true
  end

  def is_a_valid_email?
    email_regex = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    return true unless @email.match(email_regex)

    false

  end

  def save
      client = create_db_client
      sql = "INSERT INTO user (username, email, bio) VALUES ('#{username}', '#{email}', '#{bio}')"
        
      client.query(sql)
  end

  def self.sql_parse(sql_raw)
    users = []
    sql_raw.each do |row|
        user = User.new(row)
        users << user
    end
    users
  end
  
  def self.map_parse
    {
      'username' => @username,
      'email' => @email,
      'bio' => @bio
    }
  end

  def self.find_users
    client = create_db_client
    result = client.query("SELECT username, email, bio FROM user")
    sql_parse(result)
  end

  def self.find_user(username)
    client = create_db_client
    result = client.query("SELECT username, email, bio FROM user WHERE username = '#{username}'")
    sql_parse(result)
  end
  
end