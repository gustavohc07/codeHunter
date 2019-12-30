class ProposalsController < ApplicationController
  before_action :authenticate_headhunter!, only: [:new, :create]
  before_action :authenticate_candidate!, only: [:new_accept, :accept]

  def index
    if candidate_signed_in?
      @proposals = Proposal.where(candidate_id:  current_candidate)
    elsif headhunter_signed_in?
      @proposals = Proposal.where(headhunter_id: current_headhunter)
    end
  end

  def show
    @proposal = Proposal.find(params[:id])
    block_forbidden_access
  end

  def new
    @application = Application.find(params[:application_id])
    @proposal = Proposal.new
  end

  def create
    @proposal = Proposal.new(proposal_params)
    @application = Application.find(params[:application_id])
    @proposal.application = @application
    @proposal.candidate = @application.candidate
    @proposal.headhunter = current_headhunter
    if @proposal.save!
      @application.proposal_sent!
      redirect_to [@application, @proposal]
    else
      render :new
    end
  end

  def new_accept
    @proposal = Proposal.find(params[:proposal_id])
    @application = @proposal.application
    block_forbidden_access
  end

  def accept
    @proposal = Proposal.find(params[:proposal_id])
    @proposal.accept!
    reject_all_other_offers
    flash[:notice] = "Oba! Ficamos felizes que você tenha encontrado a sua oportunidade!"
    @proposal.update(proposal_params)
    redirect_to proposals_path
  end

  def new_decline
    @proposal = Proposal.find(params[:proposal_id])
    @application = @proposal.application
    block_forbidden_access
  end

  def decline
    @proposal = Proposal.find(params[:proposal_id])
    @proposal.decline!
    flash[:notice] = "Que pena que não poderá aceitar essa proposta. Mas fique tranquilo, várias outras aparecerão :)"
    @proposal.update(proposal_params)
    redirect_to proposals_path
  end

  private

  def proposal_params
    params.require(:proposal).permit(:start_date, :salary, :benefits, :bonus,
                                     :additional_info, :application_id, :acceptance_message,
                                     :reject_message, :headhunter_id, :candidate_id)
  end

  def block_forbidden_access
    unless current_candidate == @proposal.application.candidate || current_headhunter
      redirect_to proposals_path
    end
  end

  def reject_all_other_offers
    @applications = Application.where(candidate_id: current_candidate)
    @proposals = Proposal.where(application_id: @applications)
    @proposals.each do |proposal|
      if proposal.status == 'pending'
        proposal.decline!
      end
    end
  end

end