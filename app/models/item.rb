# frozen_string_literal: true

class Item < ApplicationRecord
  enum :status, %i[todo completed]
  belongs_to :user

  validates :title, presence: true
  validates :start_date_time, presence: true
  validates :end_date_time, presence: true

  def dates
    [start_date_time.strftime('%d %b %Y'), end_date_time.strftime('%d %b %Y')].uniq.join('-')
  end

  def schedule
    [start_date_time.strftime('%H:%M'), end_date_time.strftime('%H:%M')].uniq.join('-')
  end

  def toggle_status
    todo? ? update(status: :completed) : update(status: :todo)
  end
end
