# frozen_string_literal: true

class BuildItem < ApplicationService
  def initialize(user, item_params)
    @user = user
    @params = item_params
  end

  attr_reader :params, :user

  def call
    user.owned_items.new(params)
  rescue StandardError => e
    puts "An error occurred while searching the items: #{e.message}"
    raise e.message.to_s.inspect
  end
end
