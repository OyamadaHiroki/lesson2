require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validation' do
    it 'is valid with name and email, password,password_confirmation ' do
      user = build(:user)
      user.valid?
      expect(user).to be_valid
    end
    
    it 'is invalid long name more than 12 ' do
      user = build(:user, name: "aaaaaaaaaaaaaaaaaaaaaaaaa")
      expect(user.valid?).to eq(false)
    end

    it 'is invalid without name' do
      user = build(:user, name: nil)
      expect(user.valid?).to eq(false)
    end

    it 'is invalid without email' do
      user = build(:user, email: nil)
      expect(user.valid?).to eq(false)
    end

    it 'is invalid without password' do
      user = build(:user, password: nil)
      expect(user.valid?).to eq(false)
    end

    it 'is invalid password more less 6' do
      user = build(:user, password: "aaaaa")
      expect(user.valid?).to eq(false)
    end

    it 'is invalid password due to different format' do
      user = build(:user, password: "赤い羊")
      expect(user.valid?).to eq(false)
    end

  end

end
