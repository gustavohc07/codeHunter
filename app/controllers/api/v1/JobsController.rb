class Api::V1::JobsController < Api::V1::ApiController
  before_action :authenticate_headhunter!, only: [:delete]

  def index
    @jobs = Job.all
    if @jobs.any?
      return render json: { message: 'Trabalhos renderizados com sucesso',
                            data: @jobs.map do |job|
                              job.as_json.merge(image: url_for(job.photo))
                            end },
                    status: :ok
    end
    render json: { message: 'Nao encontramos registros' }, status: 404
  end

  def show
    @job = Job.find(params[:id])
    render json: { message: 'Vaga renderizada com sucesso',
                   data: @job.as_json.merge(image: url_for(@job.photo)) },
           status: :ok
  end

  def create
    @job = Job.new(job_params)
    if @job.save!
      render json: { message: 'Vaga registrada com sucesso!' }, status: 201
    end
  end

  def update
    @job = Job.find(params[:id])
    if @job.update(job_params)
      render json: { message: 'Vaga atualizada com sucesso!', data: @job }, status: :ok
    else
      render json: { message: 'Vaga nao pode ser atualizada!' }, status: 412
    end
  end

  def destroy
    @job = Job.find(params[:id])
    if current_headhunter == @job.headhunter
      @job.destroy
      render json: { message: 'Vaga excluida com sucesso!' }, status: :ok
    else
      render json: { message: 'Nao tem permissao' }, status: :forbidden
    end
  end

  private

  def job_params
    params.permit(:title, :level, :number_of_vacancies, :salary,
                  :description, :abilities, :deadline, :start_date,
                  :location, :contract_type, :headhunter_id)
  end
end