require_relative '../test_helper'
require_relative '../../app/controllers/user_controller'
require_relative '../../app/models/user'

describe UserController do
    
    describe '.save' do
        context 'when given user_data' do
            it "should fill with given params" do
                user_data = {
                    username: 'mihaamiharu',
                    email: 'mihaa@miharu.com',
                    bio: 'au ah gelap'
                }

                mock_user = double
                expect(User).to receive(:new).with(user_data).and_return(mock_user)
                allow(mock_user).to receive(:save) 

                UserController.save(user_data)
            end
        end
    end
end