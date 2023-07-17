# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ItemsSearch, type: :model do
  let(:user) { create(:user) }
  let(:item1) { create(:item, start_date_time: Time.zone.now, end_date_time: Time.zone.now+1.day, user_id: user.id)}
  let(:item2) { create(:item, start_date_time: Time.zone.now+2.days, end_date_time: Time.zone.now+4.day, user_id: user.id)}

  describe '#call' do
    it "should return item1 when we perform search with current date" do 
      item1; item2
      params = { search: Time.zone.now.strftime('%Y-%m-%d') }
      expect(ItemsSearch.call(user,params).count).to eq(1)
      expect(ItemsSearch.call(user,params).first.id).to eq(item1.id)
    end

    it "should return item2 when we perform search with day after tomorrows date" do 
      item1; item2
      params = { search: (Time.zone.now+2.days).strftime('%Y-%m-%d') }
      expect(ItemsSearch.call(user,params).count).to eq(1)
      expect(ItemsSearch.call(user,params).first.id).to eq(item2.id)
    end

    it "should return empty if no items have schedule on those days" do 
      item1; item2
      params = { search: (Time.zone.now+3.days).strftime('%Y-%m-%d') }
      expect(ItemsSearch.call(user,params).count).to eq(0)
    end
  end
end