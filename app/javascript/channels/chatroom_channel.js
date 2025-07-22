import consumer from "channels/consumer"

consumer.subscriptions.create("ChatroomChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    const messagesContainer = document.getElementById("messages-list");
    if (messagesContainer) {
      messagesContainer.insertAdjacentHTML("beforeend", data.message);
      // Scroll to bottom to show new message
      messagesContainer.scrollTop = messagesContainer.scrollHeight;
    }
  }
});
