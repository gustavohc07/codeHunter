class ProposalsController < ApplicationController
  before_action :authenticate_headhunter!, only: [:new, :create]

  def index
    @applications = Application.where(candidate_id: current_candidate)
    @proposals = Proposal.where(application_id: @applications)

  end

  def show
    @proposal = Proposal.find(params[:id])
  end

  def new
    @application = Application.find(params[:application_id])
    @proposal = Proposal.new
  end

  def create
    @proposal = Proposal.new(proposal_params)
    @application = Application.find(params[:application_id])
    @proposal.application = @application
    if @proposal.save!
      @application.proposal_sent!
      redirect_to [@application, @proposal]
    else
      render :new
    end
  end

  private

  def proposal_params
    params.require(:proposal).permit(:start_date, :salary, :benefits, :bonus,
                                     :additional_info, :application_id)
  end
end