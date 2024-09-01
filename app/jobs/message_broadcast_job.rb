class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast(
      "chat_#{message.conversation_id}",
      { message: render_message(message) }
    )
  end

  private

  def render_message(message)
    ApplicationController.renderer.new(
      http_host: 'localhost:3001',
      https: false
    ).render(
      partial: 'messages/message',
      locals: { message: message, current_user: message.sender }
    )
  end
end
