module Api::V1
  class ConversationsController < ApplicationController
    before_action :set_user

    def index
      @conversations = @user.mailbox.conversations
      render json: @conversations
    end

    def create
      params = conversation_params
      receiver = User.find_by(email: params[:receiver])
      responce = @user.send_message(receiver, params[:body], params[:subject])
      render json: responce.conversation  
    end

    def show
      conversation = @user.mailbox.conversations.find_by(id: params[:id])
      @messages = conversation.reciepts
      render json: @messages
    end

    private
    def conversation_params
      params.require(:conversation).permit(:receiver, :subject, :body)
    end

    def set_user
      @user = User.find_by(email: params[:uid])
    end
  end
end
