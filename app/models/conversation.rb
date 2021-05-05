# frozen_string_literal: true

class Conversation < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  has_many :messages, dependent: :destroy

  validates :sender_id, uniqueness: { scope: :recipient_id }

  scope :involving, lambda { |user|
    where('conversations.sender_id = ? OR conversations.recipient_id = ?', user.id, user.id)
  }

  scope :between, lambda { |sender_id, recipient_id|
                    where('(conversations.sender_id = ? AND conversations.recipient_id = ?) OR (conversations.sender_id = ? AND conversations.recipient_id = ?)',
                          sender_id, recipient_id, recipient_id, sender_id)
                  }

  def unread_message_count(current_user)
    messages.where('user_id != ? AND read = ?', current_user.id, false).count
  end
end
