class User < ApplicationRecord
    validates :username, :session_token, presence: true, uniqueness: true 
    validates :password_digest, presence: true 

    before_validation :ensure_session_token 
    attr_reader :password 

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)

        if user && user.check_password?(password) ? user : nil 
    end

    def password=(password)
        @password = password 
        self.password_digest = BCrypt::Password.create(password)
    end

    def check_password?(password)
        BCrypt::Password.new(password_digest).is_password?(password)
    end

    def rest_session_token! 
        self.session_token = SecureRandom.base64 
        self.save! 
        self.session_token
    end

    private 

    def ensure_session_token 
        self.session_token ||= SecureRandom.base64
    end


end
