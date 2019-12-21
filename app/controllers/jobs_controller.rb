class JobsController < ApplicationController
  before_action :authorize_both!, only: [:show]
  before_action :authorize_headhunter!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @jobs = Job.all
  end

  def show
    @job = Job.find(params[:id])
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      flash[:notice] = 'Vaga criada com sucesso!'
      redirect_to @job
    else
      render :new
    end
  end

  private

  def job_params
    params.require(:job).permit(:title, :level, :number_of_vacancies,
                                :salary, :description, :abilities,
                                :deadline, :start_date, :location,
                                :contract_type)
                        .merge(headhunter: current_headhunter)
  end

  def authorize_headhunter!
    redirect_to root_path, alert: 'Você deve ser um CodeHunter para acessar essa área!' unless current_headhunter
  end

  def authorize_both!
    redirect_to root_path, alert: 'Você deve estar logado para acessar essa área!' unless current_headhunter || current_candidate
  end
end