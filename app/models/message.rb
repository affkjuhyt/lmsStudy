class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  validates :body, presence: true
  after_create_commit :broadcast_to_user

  private
  
  def broadcast_to_user
    MessageBroadcastJob.perform_later(self)
  end
end
