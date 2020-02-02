# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :authenticate_headhunter!, only: %i[new create]

  def new
    @application = Application.find(params[:application_id])
    @message = Message.new(application: @application)
  end

  def create
    @application = Application.find(params[:application_id])
    @message = Message.new(message_params)
    @message.application = @application
    if @message.save
      flash[:notice] = 'Mensagem enviada com sucesso!'
      redirect_to application_path(@application)
    else
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:comment, :application_id)
  end
end
