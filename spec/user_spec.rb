require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    it "validates password length that is at least 8 digits" do
      @user = User.new(name: "Jane Doe", email: "gbknva@gmail.com", password: "Jane123", password_confirmation: "Jane123")
      expect(@user).to_not be_valid
    end
    it "does not save when name is not given" do
      @user = User.new(email: "gbknva@gmail.com", password: "Jane1234", password_confirmation: "Jane1234")
      expect(@user).to_not be_valid
      expect(@user.errors.messages).to eq ({:name => ["can't be blank"]})
    end
    it "does not save when password confirmation does not match" do
      @user = User.new(email: "gbknva@gmail.com", password: "Jane12345", password_confirmation: "Jane123465")
      expect(@user).to_not be_valid
    end

    it "validates email is present" do
      @user = User.new(name: "Jane Doe", password: "Jane1234", password_confirmation: "Jane1234")
      expect(@user).to_not be_valid
      expect(@user.errors.messages).to eq ({:email => ["can't be blank"]})
    end

    it 'validates uniqueness of email' do
      @user = User.new(name: "B", email: "gb@gmail.com", password: "Jane123456", password_confirmation: "Jane123456")
      @user.save
      @user2 = User.authenticate_with_credentials("g@gmail.com", "Jane123456")
      expect(@user).to_not be == @user2
    end
  end
  
  describe '.authenticate_with_credentials' do

    it "validates emails with spaces before/after the email" do
      @user = User.new(name: "B", email: "gb@gmail.com", password: "Jane123456", password_confirmation: "Jane123456")
      @user.save
      @user2 = User.authenticate_with_credentials(" gb@gmail.com ", "Jane123456")
      expect(@user).to be == @user2
    end
    it "validates emails with wrong case" do
      @user = User.new(name: "B", email: "GB@gmail.com", password: "Jane123456", password_confirmation: "Jane123456")
      @user.save
      @user2 = User.authenticate_with_credentials("gb@gmail.com", "Jane123456")
      expect(@user).to be == @user2
    end
  end

end