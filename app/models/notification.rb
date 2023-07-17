class Notification < ApplicationRecord
  belongs_to :user
  scope :unviewed, -> { where(viewed: false ) }
  default_scope { latest }

  after_commit do
    broadcast_replace_to "broadcast_to_user_#{self.user_id}", 
      target: "notifications_count", 
      partial: "notifications/count", 
      locals: { count: self.user.unviewed_notifications_count }
  end
end
