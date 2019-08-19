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
        p 'in user method'
        if headers['Authorization'].present?
            p 'here are headers'
            p headers['Authorization']
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
 