require 'rails_helper'

RSpec.describe Video, type: :model do
  it 'has a valid factory' do
    expect(build(:video)).to be_valid
  end

  describe 'validations' do

    it 'is invalid without user id' do
      expect(build(:video, user_id: nil)).to_not be_valid
    end

    it 'is invalid without duration' do
      expect(build(:video, duration: nil)).to_not be_valid
    end

    it 'is invalid without file_processing' do
      expect(build(:video, file_processing: nil)).to_not be_valid
    end
  end

end
