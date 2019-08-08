require 'rails_helper'

describe 'authorize api requests' do
    
    before(:each) do
        User.delete_all
    end

    it 'authorizes api requests made with a vaild jwt token' do
        user = FactoryBot.create(:user)
        command = AuthorizeApiRequest.call({'Authorization' => 'Bearer ' + JsonWebToken.encode(user_id: user.id)})
        expect(command).to be_success
        expect(command.result).to eq(user)
    end

    it 'rejects a request with inappropriate headers' do
        user = FactoryBot.create(:user)
        token = JsonWebToken.encode(user_id: user.id)
        command = AuthorizeApiRequest.call({'Wrong header' => 'Bearer ' + JsonWebToken.encode(user_id: user.id)})

        expect(command).not_to be_success
        expect(command.errors).to eq({:token => ['Malformed request']})
    end

    it 'rejects a request with no token' do
        command = AuthorizeApiRequest.call({'Authorization' => nil})
        expect(command).not_to be_success
        expect(command.errors).to eq({:token => ['Malformed request']})
    end

    it 'rejects a request with an invalid or malformed token' do
        command = AuthorizeApiRequest.call({'Authorization' => 'Bearer malformedToken'})

        expect(command).not_to be_success
        expect(command.errors).to eq({:token => ['Invalid token']})
    end

end
