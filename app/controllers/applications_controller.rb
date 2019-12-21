class ApplicationsController < ApplicationController
  before_action :authenticate_candidate!
  before_action :check_profile, only: [:show, :new, :create, :edit, :update]
  before_action :has_applied?, only: [:new, :create]

  def index
    @application = Application.where(candidate_id: current_candidate)
  end

  def show
    @application = Application.find(params[:id])
    unless current_candidate == @application.candidate
      redirect_to jobs_path
      return
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
      flash[:notice] = 'Inscrição realizada com sucesso!'
      redirect_to application_path(@application)
    end
  end

  private

  def application_params
    params.require(:application).permit(:message, :candidate_id, :job_id)
  end

  def check_profile
    if current_candidate.profile
      current_candidate.profile.attributes.each do |elem|
        if elem[1].blank?
          redirect_to edit_profile_path(current_candidate.profile), alert: 'Preencha seu perfil para aplicar à vaga!' and return
        end
      end
    else
      redirect_to new_profile_path, alert: 'Vocẽ deve possuir um perfil para aplicar à vaga'
    end
  end

  def has_applied?
    if Application.where(candidate_id: current_candidate.id, job_id: params[:job_id]).exists?
      redirect_to applications_path, alert: "Voce já está inscrito nessa vaga"
    end
  end

end