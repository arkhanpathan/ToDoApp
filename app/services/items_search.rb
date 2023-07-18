# frozen_string_literal: true

class ItemsSearch < ApplicationService
  def initialize(user, param)
    @user = user
    @params = param
  end

  attr_reader :params, :user

  def call
    owned_items = user.is_admin? ? Item.all : user.owned_items
    assigned_items = user.items
    if params[:search].present?
      owned_items = owned_items.where('start_date_time > ? and start_date_time < ?', params[:search].to_date,
                          params[:search].to_date + 1.day)
      assigned_items = assigned_items.where('start_date_time > ? and start_date_time < ?', params[:search].to_date,
                          params[:search].to_date + 1.day)
    end
    [assigned_items.order(start_date_time: :desc), owned_items.order(start_date_time: :desc)]
  rescue StandardError => e
    puts "An error occurred while searching the items: #{e.message}"
    raise e.message.to_s.inspect
  end
end
