# frozen_string_literal: true

class AssignedItem < ApplicationRecord
  enum :status, %i[todo completed]
  belongs_to :user
  belongs_to :item
  
  after_create_commit do
    message = "Admin has assigned you task #{item.title}"
    user.notifications.create(message: message)
  end
  
  after_destroy_commit do
    message = "task #{item.title} has been unassigned"
    user.notifications.create(message: message)
  end
end
