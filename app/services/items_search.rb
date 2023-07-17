# frozen_string_literal: true

class ItemsSearch < ApplicationService
  def initialize(user, param)
    @user = user
    @params = param
  end

  attr_reader :params, :user

  def call
    debugger
    items = user.is_admin? ? Item.all : user.items
    if params[:search].present?
      items = items.where('start_date_time > ? and start_date_time < ?', params[:search].to_date,
                          params[:search].to_date + 1.day)
    end
    items.order(:start_date_time)
  rescue StandardError => e
    puts "An error occurred while searching the items: #{e.message}"
    raise e.message.to_s.inspect
  end
end
