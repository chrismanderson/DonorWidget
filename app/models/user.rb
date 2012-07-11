class User < ActiveRecord::Base
  attr_accessible :email, :encrypted_password, :name
  attr_accessor :password
  validates :email, uniqueness: true


  def store_password(new_password)
    update_attribute(:encrypted_password, BCrypt::Password.create(new_password))
  end

  def validate_password(input_password)
    BCrypt::Password.new(encrypted_password) == input_password
  end

  def reset_password
    new_password = Array.new(8).map { (65 + rand(58)).chr }.join
    store_password(new_password)
    new_password
  end
end
