class AuthorizeApiRequest
    prepend SimpleCommand

    def initialize(headers = {})
        @headers = headers
    end
    
    def call
        user
    end

    private

    attr_reader :headers

    def user
        if headers['Authorization'].present?
            @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
            @user || errors.add(:token, 'Invalid token') && nil
        else
            errors.add(:token, 'Malformed request')
            nil
        end
    end

    def decoded_auth_token
        @decoded_auth_token ||= JsonWebToken.decode(headers['Authorization'].split(' ').last)
    end
end
 