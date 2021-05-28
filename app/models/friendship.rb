class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  scope :accepted, -> { where('status = ?', 'accepted') }
  scope :pending, -> { where('status = ?', 'pending') }

  validates :user_id, presence: true
  validates :friend_id, presence: true
  validates :status, presence: true
end
