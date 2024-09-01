class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = current_user.conversations
  end

  def show
    @conversation = Conversation.find(params[:id])
    @message = Message.new
    @messages = @conversation.messages.order(created_at: :asc)
  end

  def create
    @conversation = Conversation.between(current_user.id, params[:receiver_id]).first_or_create!(sender_id: current_user.id, receiver_id: params[:receiver_id])
    redirect_to conversation_path(@conversation)
  end
end
