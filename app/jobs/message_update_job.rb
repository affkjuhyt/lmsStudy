class MessageUpdateJob < ApplicationJob
  queue_as :default

  def perform(data)
    ActionCable.server.broadcast "message_channel", data
  end
end
