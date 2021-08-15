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
        end
    end
end