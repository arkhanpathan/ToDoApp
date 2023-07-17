# frozen_string_literal: true

class AssignedItem < ApplicationRecord
  enum :status, %i[todo completed]
  belongs_to :user
  belongs_to :item
end
