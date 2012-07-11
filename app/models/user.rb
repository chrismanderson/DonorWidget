class User < ActiveRecord::Base
  attr_accessible :email, :encrypted_password, :name

  def store_password(password)
    update_attribute(:encrypted_password, BCrypt::Password.create(password))
  end

  def validate_password(password)
    BCrypt::Password.new(encrypted_password) == password
  end

  def reset_password
    new_password = Array.new(8).map { (65 + rand(58)).chr }.join
    store_password(new_password)
    new_password
  end
end
