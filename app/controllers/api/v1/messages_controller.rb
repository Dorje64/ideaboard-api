module Api::V1
  class MessagesController < ApplicationController
    before_action :set_user , :set_conversation
    before_action :set_conversation
    after_action  :broadcast, only: [:create]

    def index
      # byebug
      receipts = @conversation.receipts_for(@user).includes(:message)
      messages = receipts.map{|receipt| receipt.message }
      render json: messages
    end

    def create
      # byebug
      @receipt = @user.reply_to_conversation(@conversation, params[:body])
      # render json: @receipt.message
    end

    private
    def set_conversation
      @conversation = @user.mailbox.conversations.find_by(id: params[:conversation_id])
    end

    def set_user
      @user = User.find_by(email: params[:uid])
    end

    def broadcast
      ActionCable.server.broadcast('chat_channel', message: @receipt.message)
      # MessageCreationEventBroadcastJob.perform_later(@receipt)
    end

    # def message_params
  end
end
