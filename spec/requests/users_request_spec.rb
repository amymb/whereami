require 'rails_helper'

describe 'users api' do
    
    before(:all) do
        User.delete_all
    end
    
    let(:user) { FactoryBot.create(:user) }
    let(:token) { JsonWebToken.encode(user_id: user.id) }

    it 'returns a user' do
        user2 = FactoryBot.create(:user, username: 'fakeusername2')
        headers = { 'Authorization' => 'Bearer ' + token}
        get "/users/#{user2.id}", params: {}, headers: headers

        expect(response).to be_successful
        user_response = JSON.parse(response.body)
    end
end