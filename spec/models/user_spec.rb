require_relative '../test_helper'
require_relative '../../app/models/user'
require_relative '../../app/db/db_connection'

describe User do
    describe '#initialize' do
        context 'when initialized with given params' do
            it 'should return user instance with given params' do
                fill_user = {
                    username: 'mihaamiharu',
                    email: 'mihaa@miharu.com',
                    bio: 'au ah gelap'
                }

                user = User.new(fill_user)
                expect(user.username).to eq(fill_user[:username])
                expect(user.email).to eq(fill_user[:email])
                expect(user.bio).to eq(fill_user[:bio])
            end
        end
    end

    describe '#valid?' do
        context 'when given valid params' do
            it 'should return true' do
                fill_user = {
                    username: 'mihaamiharu',
                    email: 'mihaa@miharu.com',
                    bio: 'au ah gelap'
                }

                user = User.new(fill_user)
                expect(user.valid?).to eq(true)
            end
            
            it 'should return true even bio is nil' do
                fill_user = {
                    username: 'mihaamiharu',
                    email: 'mihaa@miharu.com'    
                }

                user = User.new(fill_user)
                expect(user.valid?).to eq(true)
            end

        end

        context 'when given invalid params' do
            it 'should return false when email is nil' do
                fill_user = {
                    username: 'mihaamiharu'   
                }

                user = User.new(fill_user)
                expect(user.valid?).to be_falsey
            end

            it 'should return false when username is nil' do
                fill_user = {
                    email: 'mihaa@miharu.com'    
                }

                user = User.new(fill_user)
                expect(user.valid?).to be_falsey
            end

            it 'should return false when email format is invalid' do
                fill_user = {
                    email: 'mihaamiharu'    
                }

                user = User.new(fill_user)
                expect(user.valid?).to be_falsey
            end
        end
    end

    describe '#save' do
        context 'when user attribute is valid' do
            it 'should insert data to user table with given attribute' do
                fill_user = {
                    username: 'mihaamiharu',
                    email: 'mihaa@miharu.com',
                    bio: 'au ah gelap'
                }

                user = User.new(fill_user)
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
            fill_user = {
                'username' => 'mihaamiharu',
                'email' => 'mihaa@miharu.com',
                'bio' => 'au ah gelap'
            }

            sql_data = [fill_user]
            user = User.new(fill_user)
            expected_result = [user]
            sql_data.each do |data|
                allow(User).to receive(:new).with(data).and_return(user)
            end
            expect(User.sql_parse(sql_data)).to eq(expected_result)
        end
    end

    describe '#convert_json' do
        context 'convert object to JSON' do
            it 'should return as JSON' do
                user = User.new({
                    'username' => 'mihaamiharu',
                    'email' => 'mihaa@miharu.com',
                    'bio' => 'au ah gelap'
                })

                expected_result = {
                    username: user.username,
                    email: user.email,
                    bio: user.bio
                }

                expect(user.convert_json).to eq(expected_result)
            end
        end
    end
end