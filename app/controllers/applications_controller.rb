class ApplicationsController < ApplicationController
  before_action :authenticate_candidate!
  before_action :check_profile, only: [:show, :new, :create, :edit, :update]

  def show
    @application = Application.find(params[:id])
  end

  def new
    @application = Application.new(job_id: params[:job_id])
  end

  def create
    @application = Application.new(application_params)
    @job = Job.find(params[:application][:job_id])
    if @application.save!
      flash[:notice] = 'Inscrição realizada com sucesso!'
      redirect_to @application
    end
  end

  private

  def application_params
    params.require(:application).permit(:message, :candidate_id, :job_id)
                                .merge(candidate: current_candidate)
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
end