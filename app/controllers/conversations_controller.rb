class ConversationsController < ApplicationController
  before_action :logged_in_user

  def index
    @users = User.all
    @conversations = Conversation.involving(current_user)
  end

  def create
    @conversation = if Conversation.between(params[:sender_id], params[:recipient_id]).present?
      Conversation.between(params[:sender_id], params[:recipient_id]).first
    else
      Conversation.create(conversation_params)
    end

    redirect_to conversation_messages_path(@conversation)
  end

  private

  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
end
