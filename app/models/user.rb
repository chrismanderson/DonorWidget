class User < ActiveRecord::Base
  attr_accessible :email, :encrypted_password, :name
  attr_accessor :password
  validates :email, uniqueness: true
  has_many :widgets
  has_many :projects, through: :widgets

  def store_password(new_password)
    update_attribute(:encrypted_password, BCrypt::Password.create(new_password))
  end

  def validate_password(input_password)
    BCrypt::Password.new(encrypted_password) == input_password
  end

  def reset_password
    new_password = generate_random_password
    store_password(new_password)
    send_password_email(new_password)
  end

  private

  def send_password_email(new_password)
    # Pending installation of mailer
    new_password
  end

  def generate_random_password
    Array.new(8).map { (65 + rand(58)).chr }.join
  end
end
