require_relative '../test_helper'
require_relative '../spec_helper'
require_relative '../../app/models/user'
require_relative '../../app/db/db_connection'

describe User do
    describe '#initialize' do
        context 'when initialized with given params' do
            it 'should return user instance with given params' do
                user_data = {
                    username: 'mihaamiharu',
                    email: 'mihaa@miharu.com',
                    bio: 'au ah gelap'
                }

                user = User.new(user_data)
                expect(user.username).to eq(user_data[:username])
                expect(user.email).to eq(user_data[:email])
                expect(user.bio).to eq(user_data[:bio])
            end
        end
    end

    describe '#valid?' do
        context 'when given valid params' do
            it 'should return true' do
                user_data = {
                    username: 'mihaamiharu',
                    email: 'mihaa@miharu.com',
                    bio: 'au ah gelap'
                }

                user = User.new(user_data)
                expect(user.valid?).to eq(true)
            end
            
            it 'should return true even bio is nil' do
                user_data = {
                    username: 'mihaamiharu',
                    email: 'mihaa@miharu.com'    
                }

                user = User.new(user_data)
                expect(user.valid?).to eq(true)
            end

        end

        context 'when given invalid params' do
            it 'should return false when email is nil' do
                user_data = {
                    username: 'mihaamiharu'   
                }

                user = User.new(user_data)
                expect(user.valid?).to be_falsey
            end

            it 'should return false when username is nil' do
                user_data = {
                    email: 'mihaa@miharu.com'    
                }

                user = User.new(user_data)
                expect(user.valid?).to be_falsey
            end

            it 'should return false when email format is invalid' do
                user_data = {
                    email: 'mihaamiharu'    
                }

                user = User.new(user_data)
                expect(user.valid?).to be_falsey
            end
        end
    end

    describe '#save' do
        context 'when user attribute is valid' do
            it 'should insert data to user table with given attribute' do
                user_data = {
                    username: 'mihaamiharu',
                    email: 'mihaa@miharu.com',
                    bio: 'au ah gelap'
                }

                user = User.new(user_data)
                sql = "INSERT INTO user (username, email, bio) VALUES ('#{user.username}', '#{user.email}', '#{user.bio}')"
                mock_db = double
                allow(Mysql2::Client).to receive(:new).and_return(mock_db)
                expect(mock_db).to receive(:query).with(sql)

                user.save
            end
        end
    end

    describe '.sql_parse' do
        it 'should return rawsql data to ruby array object' do
            user_data = {
                'username' => 'mihaamiharu',
                'email' => 'mihaa@miharu.com',
                'bio' => 'au ah gelap'
            }

            sql_data = [user_data]
            user = User.new(user_data)
            expected_result = [user]
            sql_data.each do |data|
                allow(User).to receive(:new).with(data).and_return(user)
            end
            expect(User.sql_parse(sql_data)).to eq(expected_result)
        end
    end

    describe '.map_parse' do
        it 'should convert sql_parse to map format' do
            user_data = {
                'username' => @username,
                'email' => @email,
                'bio' => @bio
            }

            map_data = user_data
            user = User.new(user_data)
            map_data.each do |data|
                allow(User).to receive(:new).with(data).and_return(user)
            end
            expect(User.map_parse).to eq(user_data)
        end
    end

    describe '.find_users' do
        context 'data user is found' do
            it 'should return all user' do
                user_data = {
                    username: 'mihaamiharu',
                    email: 'mihaa@miharu.com',
                    bio: 'au ah gelap'
                }

                user = User.new(user_data)
                
                mock_result = [{
                    "username" => user.username,
                    "email" => user.email,
                    "bio" => user.bio
                }]

                sql_query = "SELECT username, email, bio FROM user"

                mock_db = double
                allow(Mysql2::Client).to receive(:new).and_return(mock_db)
                expect(mock_db).to receive(:query).with(sql_query).and_return(mock_result)

                User.find_users
            end
        end
    end

    describe '.find_user_by_username' do
        context 'username is found' do
            it 'should return user for selected username' do
                user_data = {
                    username: 'mihaamiharu',
                    email: 'mihaa@miharu.com',
                    bio: 'au ah gelap'
                }

                user = User.new(user_data)

                mock_result = [{
                    "username" => user.username,
                    "email" => user.email,
                    "bio" => user.bio
                }]

                sql_query = "SELECT username, email, bio FROM user WHERE username = '#{user.username}'"

                mock_db = double
                allow(Mysql2::Client).to receive(:new).and_return(mock_db)
                expect(mock_db).to receive(:query).with(sql_query).and_return(mock_result)

                User.find_user(user.username)
            end
        end
    end

end