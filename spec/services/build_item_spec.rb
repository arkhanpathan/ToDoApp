# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BuildItem, type: :model do
  let(:user) { create(:user) }

  describe '#call' do
    let(:item_attributes) {
                            { 
                              title: 'Attend standup',
                              description: 'Discuss on outstanding high priority tickets',
                              start_date_time: DateTime.current,
                              end_date_time: DateTime.current + 1.hour,
                              status: 'todo'
                            }
                          }

    it 'builds the item with provided attributes' do
      expect(BuildItem.call(user,item_attributes).class).to eq(Item)
    end

    it "should be build valid item with required attributes" do 
      expect(BuildItem.call(user,item_attributes)).to be_valid
    end

    it 'should be invalid without title' do
      expect(BuildItem.call(user,item_attributes.except(:title))).to be_invalid
    end

    it 'should be invalid without start_date_time' do
      expect(BuildItem.call(user,item_attributes.except(:start_date_time))).to be_invalid
    end

    it 'should be invalid without end_date_time' do
      expect(BuildItem.call(user,item_attributes.except(:end_date_time))).to be_invalid
    end
  end
end
