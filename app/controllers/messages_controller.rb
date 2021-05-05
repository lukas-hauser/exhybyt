# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :logged_in_user
  before_action :set_conversation

  def index
    if current_user == @conversation.sender || current_user == @conversation.recipient
      @other = current_user == @conversation.sender ? @conversation.recipient : @conversation.sender
      @messages = @conversation.messages.order('created_at DESC')
      @messages.where('user_id != ? AND read = ?', current_user.id, false).update_all(read: true,
                                                                                      read_at: Time.zone.now)
    else
      redirect_to conversations_path, alert: "You don't have permission to view this"
    end
  end

  def create
    @message = @conversation.messages.new(message_params)
    @messages = @conversation.messages.order('created_at DESC')

    if @message.save
      respond_to do |format|
        format.html { redirect_to conversation_messages_path(@conversation) }
        format.js
      end
    end
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def message_params
    params.require(:message).permit(:content, :user_id)
  end
end
