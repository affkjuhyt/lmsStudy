import consumer from "./consumer"

consumer.subscriptions.create("MessageChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    var node = document.createElement("p")
    var textnode = document.createTextNode(data.content.content);
    node.id = data.content.id;
    node.appendChild(textnode);
    document.getElementById("new_message").appendChild(node);
  }
});
