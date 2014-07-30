class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :set_conversation, only: [:create]

  def new
    @message = Message.new
  end

  def create
    @message = @conversation.messages.build(message_params)
    @message.save
  end

  private

    def set_message
      @message = Message.find(params[:id])
    end

    def set_conversation
      @conversation = Conversation.find(params[:conversation_id])
    end


    def message_params
      params.require(:message).permit! if params[:message]
    end
end
