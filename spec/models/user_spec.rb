# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe 'associations' do
    it 'has many items' do
      association = described_class.reflect_on_association(:items)

      expect(association.macro).to eq(:has_many)
    end
  end

  describe 'devise modules' do
    it 'includes the necessary devise modules' do
      expect(described_class.devise_modules).to include(:database_authenticatable, :registerable, :recoverable,
                                                        :rememberable, :validatable)
    end
  end

  describe 'full_name' do
    it 'should return users full name on call' do
      expect(user.full_name).to eq("#{user.first_name} #{user.last_name}")
    end
  end
end
