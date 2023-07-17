# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  scope :not_admin, -> { where(is_admin: false ) } 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :assigned_items
  has_many :items, through: :assigned_items
  has_many :owned_items, class_name: 'Item', foreign_key: 'user_id'

  def full_name
    "#{first_name} #{last_name}"
  end
end 
