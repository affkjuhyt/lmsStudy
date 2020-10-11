module ApplicationHelper
  def avatar_user_tag user, class_name, avatar_size
    image_tag user.avatar_url ? user.avatar_url : "profile.png",
      class: class_name.to_sym, size: avatar_size
  end

  def chat_type room
    chat_room = room.class.name
    chat_room == User.name ? Conversation.name : chat_room
  end

  def allow_render_message message, active_room
    message.chat_room_type == Conversation.name && active_room.to_i != current_user.id
  end

  def unseen_number current_user, chat_room
    chat_room = Conversation.existing_conversation(
      chat_room.id, current_user.id).first if chat_room.class.name == "User"

    count = 0
    count = chat_room.messages.unread_by(current_user).size if chat_room
    count > 0 ? count : nil
  end

  def image_object chat_room
    if chat_room.class.name == "User"
      avatar_user_tag chat_room, "img-circle",
        Settings.image_size_40
    elsif chat_room.class.name == "Course"
      image_course_tag chat_room, "img-circle",
        Settings.image_size_40
    end
  end
end
