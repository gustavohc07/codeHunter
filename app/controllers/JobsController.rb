class JobsController < ApplicationController
  before_action :authenticate_headhunter!, only: [:show, :new, :create, :edit, :update, :destroy]

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
  end
end