class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :load_message, only: [:index, :new]

  def index; end

  def show; end

  def new
    @message = Message.new
  end

  def create
    @conversation = Conversation.find_by(recipient_id: current_user.id)
    @message = current_user.messages.build(message_params)
    @message.update(conversation_id: @conversation.id)
    respond_to do |format|
      if @message.save
        ActionCable.server.broadcast 'conversation_channel', content: @message
        format.html { redirect_to @message, notice: 'Chat was successfully created.' }
        format.json { render :show, status: :created, location: @message }
        format.js
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def load_message
    @messages = Message.all
  end

  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:body, :user_id)
  end
end
