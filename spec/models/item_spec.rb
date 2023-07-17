# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:user) { create(:user) }
  let(:item) { create(:item, user_id: user.id) }

  describe 'validations' do
    it 'should be valid in presence of all field' do
      expect(build(:item, user_id: user.id)).to be_valid
    end

    it 'should be invalid without user' do
      expect(build(:item)).to be_invalid
    end

    it 'should not be valid without title' do
      expect(build(:item, user_id: user.id, title: nil)).to be_invalid
    end

    it 'should not be valid without start_date_time' do
      expect(build(:item, user_id: user.id, start_date_time: nil)).to be_invalid
    end

    it 'should not be valid without end_date_time' do
      expect(build(:item, user_id: user.id, end_date_time: nil)).to be_invalid
    end
  end

  describe 'dates' do
    it 'returns single day if the item have start and end on same day' do
      build(:item, user_id: user.id, start_date_time: Time.zone.now, end_date_time: Time.zone.now + 2.hours)
      expect(item.dates).to eq(Time.zone.now.strftime('%d %b %Y'))
    end

    it 'returns - separated dates if the item have different start and end date' do
      item = create(:item, user_id: user.id, start_date_time: Time.zone.now, end_date_time: Time.zone.now + 2.days)
      expect(item.dates).to eq("#{Time.zone.now.strftime('%d %b %Y')}-#{(Time.zone.now + 2.days).strftime('%d %b %Y')}")
    end
  end

  describe 'schedule' do
    it 'returns single time if the item have start and end time' do
      current_time = Time.zone.now
      item = build(:item, user_id: user.id, start_date_time: current_time, end_date_time: current_time)
      expect(item.schedule).to eq(current_time.strftime('%H:%M'))
    end

    it 'returns - separated time if the item have different start and end time' do
      item = create(:item, user_id: user.id, start_date_time: Time.zone.now, end_date_time: Time.zone.now + 1.hour)
      expect(item.schedule).to eq("#{Time.zone.now.strftime('%H:%M')}-#{(Time.zone.now + 1.hour).strftime('%H:%M')}")
    end
  end

  describe 'toggle_status' do
    it 'should update the item status to todo if its completed' do
      expect(item.todo?).to be_truthy
      item.toggle_status
      expect(item.completed?).to be_truthy
    end

    it 'should update the item status to complete if its todo' do
      item.toggle_status
      expect(item.completed?).to be_truthy
      item.toggle_status
      expect(item.todo?).to be_truthy
    end
  end
end
