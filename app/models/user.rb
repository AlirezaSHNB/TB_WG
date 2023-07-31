class User < ApplicationRecord
  has_secure_password

  # Generate a unique token for the user
  def generate_token
    payload = { user_id: id }
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  # Find a user by the token
  def self.find_by_token(token)
    decoded_token = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
    find_by(id: decoded_token['user_id'])
  rescue JWT::DecodeError
    nil
  end
end
