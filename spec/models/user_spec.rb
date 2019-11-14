require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  describe 'validations' do

    it 'is invalid without token' do
      expect(build(:user, token: nil)).to_not be_valid
    end
  end
end
