class FeedbacksController < ApplicationController
  before_action :authenticate_headhunter!

  def new
    @application = Application.find(params[:application_id])
    @feedback = Feedback.new(application: @application)
  end

  def create
    @feedback = Feedback.new(feedback_params)
    @application = Application.find(params[:application_id])
    @feedback.application = @application
    if @feedback.save
      @application.rejected!
      flash[:alert] = 'Que pena que esse candidato não atendeu às suas expectativas :('
      redirect_to application_path(@application)
    else
      render :new
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:feedback_message, :application_id)
  end
end