class ApplicationsController < ApplicationController
  before_action :authenticate_candidate!, only: [:index, :new, :create, :destroy]
  before_action :authenticate_headhunter!, only: [:highlight, :cancel_highlight]
  before_action :authorize_both!, only: [:show]
  before_action :check_profile, only: [:show, :new, :create, :edit, :update]
  before_action :has_applied?, only: [:new, :create]
  before_action :check_for_closed_jobs, only: [:new, :create]

  def index
    @application = Application.where(candidate_id: current_candidate)
  end

  def show
    @application = Application.find(params[:id])
    @messages = @application.messages
    @profile = @application.candidate.profile
    unless current_candidate == @application.candidate || current_headhunter
      redirect_to jobs_path
    end
  end

  def new
    @application = Application.new(job_id: params[:job_id])
  end

  def create
    @application = Application.new(application_params)
    @application.job = Job.find(params[:job_id])
    @application.candidate = current_candidate
    if @application.save
      JobApplicationMailer.application_email(@application.id)
      flash[:notice] = 'Inscrição realizada com sucesso!'
      redirect_to application_path(@application)
    end
  end

  def destroy
    @application = Application.find(params[:id])
    @application.destroy
    flash[:notice] = 'Poxa! Que pena que você não poderá participar desse processo! :('
    redirect_to applications_path
  end

  def highlight
    @application = Application.find(params[:application_id])
    @application.highlighted!
    flash[:notice] = 'Perfil destacado!'
    redirect_to application_path(@application)
  end

  def cancel_highlight
    @application = Application.find(params[:application_id])
    @application.in_progress!
    flash[:notice] = 'Retirado destaque do perfil'
    redirect_to application_path(@application)
  end

  private

  def application_params
    params.require(:application).permit(:message, :candidate_id, :job_id)
  end

  def check_profile
    if candidate_signed_in?
      if current_candidate.profile
        current_candidate.profile.attributes.each do |elem|
          if elem[1].blank?
            redirect_to(edit_profile_path(current_candidate.profile), alert: 'Preencha seu perfil para aplicar à vaga!') && break
          end
        end
      else
        redirect_to new_profile_path, alert: 'Vocẽ deve possuir um perfil para aplicar à vaga'
      end
    end
  end

  def has_applied?
    if Application.where(candidate_id: current_candidate.id, job_id: params[:job_id]).exists?
      redirect_to applications_path, alert: "Voce já está inscrito nessa vaga"
    end
  end

  def authorize_both!
    redirect_to root_path, alert: 'Você deve estar logado para acessar essa área!' unless current_headhunter || current_candidate
  end

  def check_for_closed_jobs
    @job = Job.find(params[:job_id])
    if @job.status == 'close'
      redirect_to jobs_path, alert: 'Inscrições para essa vaga foram encerradas!'
    end
  end
end