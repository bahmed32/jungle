require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it 'checks that the user is created and saved' do
      @user = User.create(first_name: 'Jane', last_name: 'Doe', email: 'test@test.com', password: 'password', password_confirmation: 'password')
      expect(@user).to be_valid
    end

    it 'throws error when first name is blank' do
      @user = User.create( last_name: 'Doe', email: 'test@test.com', password: 'password', password_confirmation: 'password')
      expect(@user).to_not be_valid
      expect(@user.errors.messages[:first_name]).to include "can't be blank"

    end

    it 'throws error when last name is blank' do
      @user = User.create( first_name: 'Jane', email: 'test@test.com', password: 'password', password_confirmation: 'password')
      expect(@user).to_not be_valid
      expect(@user.errors.messages[:last_name]).to include "can't be blank"

    end

    it 'throws error when password is blank' do
      @user = User.create( first_name: 'Jane', last_name: 'Doe', email: 'test@test.com', password_confirmation: 'password')
      expect(@user).to_not be_valid
      expect(@user.errors.messages[:password]).to include "can't be blank"

    end

    it 'throws error when password confirmation is blank' do
      @user = User.create( first_name: 'Jane', last_name: 'Doe', email: 'test@test.com', password: 'password')
      expect(@user).to_not be_valid
      expect(@user.errors.messages[:password_confirmation]).to include "can't be blank"

    end

    it 'checks that passworsds arent too short' do 
      @user = User.create(first_name: 'Jane', last_name: 'Doe', email: 'test@test.com', password: 'hello', password_confirmation: 'password')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages[0]).to include "Password confirmation doesn't match Password"
    
    end
    
    it 'checks that pass and pass confirmation are the same' do
    @user = User.create(first_name: 'Jane', last_name: 'Doe', email: 'test@test.com', password: 'PASSWORD', password_confirmation: 'password')
    expect(@user).to_not be_valid
    expect(@user.errors.full_messages[0]).to include "doesn't match"
    end

    it 'checks that email is hasnt been used' do 
      @user1 = User.create(first_name: 'Jane', last_name: 'Doe', email: 'test@test.com', password: 'password', password_confirmation: 'password')
      @user2 = User.create(first_name: 'Jane', last_name: 'Doe', email: 'test@test.com', password: 'password', password_confirmation: 'password')

      expect(@user1).to be_valid
      expect(@user2).to_not be_valid

      expect(@user2.errors.messages[:email]).to include "has already been taken"
    end
  

    
    it 'checks email without case sensitivityy' do
      @user1 = User.create(first_name: 'Jane', last_name: 'Doe', email: 'test@test.com', password: 'password', password_confirmation: 'password')
      @user2 = User.create(first_name: 'Jane', last_name: 'Doe', email: 'TEST@test.com', password: 'password', password_confirmation: 'password')
      
      expect(@user1).to be_valid
      expect(@user2).to_not be_valid
      
      expect(@user2.errors.messages[:email]).to include "has already been taken"
    end
    
    # for authentication of a user
    describe '.authenticate_with_credentials' do
      before(:each) do
        @user = User.create(first_name: 'Jane', last_name: 'Doe', email: 'test@test.com', password: 'password', password_confirmation: 'password')
      end

      it 'returns users with matching email and password' do 
        authenticated_user = User.authenticate_with_credentials('test@test.com', 'password')
        expect(authenticated_user).to eq @user
      end
      end

      it 'returns nil with unmatching email and password' do
        expect(User.authenticate_with_credentials('test@test.com', 'password')).to eq nil
        expect(User.authenticate_with_credentials('test@test.com', '123')).to eq nil
      end 

      it 'returns a user with matching email and password in upper case' do
        expect(User.authenticate_with_credentials('TEST@test.com', 'password')).to eq @user
      end

      it 'returns a user with matching email with spaces and password' do
        expect(User.authenticate_with_credentials('     test@test.com', 'password')).to eq @user
      end

  end 
end
