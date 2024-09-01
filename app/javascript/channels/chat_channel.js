
import consumer from "./consumer"

const initializeChatChannel = () => {
  const conversation_element = document.getElementById('conversation-id');
  if (conversation_element) {
    const conversation_id = conversation_element.getAttribute('data-conversation-id');

    consumer.subscriptions.create({ channel: "ChatChannel", conversation_id: conversation_id }, {
      connected() {
        console.log("Connected to ChatChannel");
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
      },

      received(data) {
        console.log("Received data:", data);
        const messageContainer = document.querySelector('#messages');
        messageContainer.insertAdjacentHTML('beforeend', data.message);
        messageContainer.scrollTop = messageContainer.scrollHeight;
      },

      speak: function(message) {
        return this.perform('speak', { message: message, conversation_id: conversation_id });
      }
    });

    const messageForm = document.querySelector('#message-form');
    const messageInput = document.querySelector('#message-input');

    messageForm.addEventListener('submit', (e) => {
      e.preventDefault();
      const message = messageInput.value.trim();
      if (message.length > 0) {
        consumer.subscriptions.subscriptions[0].speak(message);
        messageInput.value = '';
      }
    });
  }
}

document.addEventListener('turbolinks:load', initializeChatChannel);
document.addEventListener('DOMContentLoaded', initializeChatChannel);