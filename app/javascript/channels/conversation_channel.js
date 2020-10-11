var App = {};

import consumer from "./consumer"

App.conversation = consumer.subscriptions.create("ConversationChannel", {
  connected: function() {
  },

  disconnected: function() {
  },

  received: function(data) {
    var conversation = $('#conversations-list').find("[data-conversation-id='" + data['conversation_id'] + "']");
    conversation.find('.messages-list').find('ul').append(data['message']);
    var messages_list = conversation.find('.messages-list');
    var height = messages_list[0].scrollHeight;
    messages_list.scrollTop(height);
  },

  chat: function(message) {
    return this.perform('chat', {
      message: message
    });
  }
});

$(document).on('submit', '.new_message', function(e) {
  e.preventDefault();
  var conversation_id = $(this).find("input[name='conversation_id']").val();
  var body = $(this).find("textarea[name='body']").val();
  var values = {conversation_id: conversation_id, body: body};
  App.conversation.chat(values);
  $(this).trigger('reset');
});
