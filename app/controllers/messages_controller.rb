class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.new(message_params)
    @message.sender = current_user
    @message.receiver = @conversation.sender == current_user ? @conversation.receiver : @conversation.sender

    if @message.save
      redirect_to conversation_path(@conversation)
    else
      render 'conversations/show'
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
