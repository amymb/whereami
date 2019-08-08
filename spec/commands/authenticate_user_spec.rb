require 'rails_helper'

describe 'authenticate user' do
    before(:each) do
        User.delete_all
    end

    it 'returns an encoded user_id for a user with valid credentials' do
        user = FactoryBot.create(:user)
        command = AuthenticateUser.call(user.username, user.password)
        expect(command).to be_success
        expect(JsonWebToken.decode(command.result)['user_id']).to eq(user.id)
    end

    it 'rejects a user with invalid password' do
        user = FactoryBot.create(:user)
        command = AuthenticateUser.call(user.username, "fakepassword")

        expect(command).not_to be_success
        expect(command.errors).to eq(:user_authentication => ["invalid credentials"])
    end
end
