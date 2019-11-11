module UserService

  def self.subscibe_new_user
    user = User.new
    user.token = generate_token
    user
  end

  def self.generate_token
    SecureRandom.hex(10)
  end
end

