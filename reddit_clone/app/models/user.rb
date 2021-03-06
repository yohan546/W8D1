# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  session_token   :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
    validates :username, :session_token, presence: true, uniqueness: true 
    validates :password_digest, presence: true 

    before_validation :ensure_session_token 
    attr_reader :password 

    has_many :subs,
        foreign_key: :moderator,
        class_name: :Sub
    
    has_many :posts,
        foreign_key: :author_id,
        class_name: :Post

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)

        user && user.check_password?(password) ? user : nil 
    end

    def password=(password)
        @password = password 
        self.password_digest = BCrypt::Password.create(password)
    end

    def check_password?(password)
        BCrypt::Password.new(password_digest).is_password?(password)
    end

    def reset_session_token! 
        self.session_token = SecureRandom.base64 
        self.save! 
        self.session_token
    end

     

    def ensure_session_token 
        self.session_token ||= SecureRandom.base64
    end


end
