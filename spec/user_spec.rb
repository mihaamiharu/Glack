require_relative './test_helper'
require_relative '../app/models/user'
require_relative '../app/db/db_connection'

describe User do
    describe '#initialize' do
        context 'when initialized with given params' do
            it 'should return user instance with given params' do
                fill_user = {
                    username: 'mihaamiharu',
                    email: 'mihaa@miharu.com',
                    bio: 'au ah gelap'
                }

                user = User.new(user_data)
                expect(user.username).to eq(fill_user[:username])
                expect(user.email).to eq(fill_user[:email])
                expect(user.bio).to eq(fill_user[:bio])
            end
        end
    end
end