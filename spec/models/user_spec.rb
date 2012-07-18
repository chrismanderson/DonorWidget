require 'spec_helper'

describe User do
  it "stores and hashes a password" do
    u = User.create
    u.encrypted_password.should be_blank
    u.store_password("foo")
    u.encrypted_password.should_not be_blank
  end

  it "validates correct passwords" do
    u = User.create
    u.store_password("foo")
    u.validate_password("foo").should be_true
  end

  it "does not validate incorrect passwords" do
    u = User.create
    u.store_password("foo")
    u.validate_password("bar").should be_false
  end

  it "resets passwords to random 8-letter values" do
    u = User.create
    pw = u.reset_password
    pw.length.should == 8
    puts pw
    u.validate_password(pw).should be_true

    u.reset_password
    u.validate_password(pw).should be_false
  end
end
