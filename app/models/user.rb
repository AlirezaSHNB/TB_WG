class User < ApplicationRecord
  has_secure_password

  # Generate a unique token for the user
  def generate_token
    payload = { user_id: id }
    secret_key = Rails.application.secrets.secret_key_base
    Base64.encode64("#{payload.to_json}--#{hmac_digest(payload, secret_key)}")
  end

  # Find a user by the token
  def self.find_by_token(token)
    token, digest = Base64.decode64(token).split('--')
    payload = JSON.parse(token)
    user = find_by(id: payload['user_id'])
    return nil unless user

    secret_key = Rails.application.secrets.secret_key_base
    return nil unless hmac_digest(payload, secret_key) == digest

    user
  rescue StandardError
    nil
  end

  private

  def hmac_digest(payload, secret_key)
    OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), secret_key, payload.to_json)
  end
end
