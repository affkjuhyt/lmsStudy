class SendNotiJob < ApplicationJob
  queue_as :default

  def perform(course, user, current_user)
    Notification.create(recipient: user, actor: current_user, action: 'created', notifiable: course)
  end
end
