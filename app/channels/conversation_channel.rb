class ConversationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "conversations-#{current_user.id}"
  end

  def unsubscribed
    stop_all_streams
  end

  def chat data
    conversation_id = data['message']["conversation_id"].try(:to_i)
    if conversation_valid? conversation_id
      message_params = data['message']
      current_user.messages.create(message_params)
    end
  end

  private

  def conversation_valid? conversation_id
    valid_conversation_ids = current_user.conversations.pluck(:id)
    valid_conversation_ids.include? conversation_id
  end
end
