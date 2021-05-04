class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates :content, presence: true, length: {maximum: 1000}
  validates :conversation_id, presence: true
  validates :user_id, presence: true

  default_scope -> { order(created_at: :desc) }

  def message_time
    created_at.strftime("%d %b %Y")
  end
end
