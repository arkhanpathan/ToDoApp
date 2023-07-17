# frozen_string_literal: true

class NotificationsController < ApplicationController
  before_action :read_all_notifications, only: %i[index]
  def index
    @notifications = current_user.notifications
  end
  
  private
  def read_all_notifications
    current_user.read_all_notifications
  end
end