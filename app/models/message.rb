class Message < ApplicationRecord
  belongs_to :user

  validates :content, presence: true

  def message_to_stream(action_type, display, current_user_id)
    data = {
      action: action_type,
      user_id: user_id,
      answer_html: message_html_render(display, current_user_id),
      other_answer_html: message_html_render(display, nil),
      id: id
    }    
    MessageUpdateJob.perform_later(data)
  end

  private

  def message_html_render(display, current_user_id)
    ApplicationController.render(
      partial: "messages/message",
      locals: { message: self, current_user_id: current_user_id }
    )
  end
end
