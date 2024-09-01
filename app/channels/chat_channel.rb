class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_#{params[:conversation_id]}"
    ActionCable.server.broadcast "chat_#{params[:conversation_id]}", { message: "Connected to chat" }
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    message = Message.create!(
      content: data['message'],
      conversation_id: data['conversation_id'],
      sender: current_user,
      receiver: Conversation.find(data['conversation_id']).sender == current_user ? Conversation.find(data['conversation_id']).receiver : Conversation.find(data['conversation_id']).sender
    )
    MessageBroadcastJob.perform_later(message)
  end
end
