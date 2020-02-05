# frozen_string_literal: true

require 'rails_helper'

describe 'Job management' do
  context 'index' do
    it 'should render all jobs correctly' do
      image_path = Rails.root.join('spec/support/image.png')
      headhunter = create(:headhunter)
      job1 = build(:job, headhunter: headhunter)
      job1.photo.attach(io: File.open(image_path),
                        filename: 'image.png')
      job1.save
      job2 = build(:job, title: 'Programador Node',
                    number_of_vacancies: 2,
                    description: 'Programador NodeJs com experiencia com git',
                    abilities: 'NodeJs, Git, Git Flow, RESTful API',
                    headhunter: headhunter)
      job2.photo.attach(io: File.open(image_path),
                        filename: 'image.png')
      job2.save
      get api_v1_jobs_path

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json[:message]).to eq('Trabalhos renderizados com sucesso')
      expect(json[:data][0][:title]).to eq(job1.title)
      expect(json[:data][0][:number_of_vacancies]).to eq(job1.number_of_vacancies)
      expect(json[:data][0][:description]).to eq(job1.description)
      expect(json[:data][1][:title]).to eq(job2.title)
      expect(json[:data][1][:number_of_vacancies]).to eq(job2.number_of_vacancies)
      expect(json[:data][1][:description]).to eq(job2.description)
    end

    it 'should render not found if there is no record' do
      get api_v1_jobs_path

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:not_found)
      expect(json[:message]).to eq('Nao encontramos registros')
    end

    xit 'should render status 500 if internal error occur' do
      allow_any_instance_of(Job).to receive(:title).and_raise(ActiveRecord::ActiveRecordError)

      get api_v1_jobs_path

      expect(response).to have_http_status(500)
    end
  end

  context 'show' do
    it 'should render a job correctly' do
      image_path = Rails.root.join('spec/support/image.png')
      headhunter = create(:headhunter)
      job = build(:job, headhunter: headhunter)
      job.photo.attach(io: File.open(image_path),
                        filename: 'image.png')
      job.save

      get api_v1_job_path(job)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json[:data][:title]).to eq('Programador RoR')
    end

    it 'job does not exist' do
      get api_v1_job_path(id: 999)

      expect(response).to have_http_status(:not_found)
      expect(response.body).to include('Nao encontramos registros!')
    end
  end

  context 'create' do
    it 'should create a job successfully' do
      headhunter = create(:headhunter)

      post api_v1_jobs_path, params: {
        title: 'Programador NodeJS',
        level: 'Junior',
        number_of_vacancies: 4,
        salary: 3000,
        description: 'Saber fazer testes em NodeJS',
        abilities: 'Git, Git flow, NodeJS, Tester',
        deadline: '20/03/2020',
        start_date: '20/01/2020',
        location: 'Remoto',
        contract_type: 'CLT',
        headhunter_id: headhunter.id
      }

      job = Job.last
      expect(response).to have_http_status(:created)
      expect(job.title).to eq('Programador NodeJS')
      expect(job.level).to eq('Junior')
      expect(job.number_of_vacancies).to eq(4)
      expect(Job.count).to eq(1)
    end

    it 'should not create if missing params' do
      post api_v1_jobs_path, params: {}

      expect(response).to have_http_status(412)
    end

    it 'should return status 500 if internal error occur' do
      allow_any_instance_of(Job).to receive(:save!).and_raise(ActiveRecord::ActiveRecordError)

      headhunter = create(:headhunter)

      post api_v1_jobs_path, params: { title: 'Programador NodeJS',
                                       level: 'Junior',
                                       number_of_vacancies: 4,
                                       salary: 3000,
                                       description: 'Saber fazer testes em NodeJS',
                                       abilities: 'Git, Git flow, NodeJS, Tester',
                                       deadline: '20/03/2020',
                                       start_date: '20/01/2020',
                                       location: 'Remoto',
                                       contract_type: 'CLT',
                                       headhunter_id: headhunter.id }

      expect(response).to have_http_status(500)
      expect(response.body).to include('Estamos trabalhando para resolver!')
    end
  end

  context 'update' do
    it 'should update a job correctly' do
      headhunter = create(:headhunter)
      job = create(:job, headhunter: headhunter)

      login_as headhunter, scope: :headhunter
      patch api_v1_job_path(job), params: { number_of_vacancies: 2,
                                            location: 'Sao Paulo' }

      job.reload
      expect(response).to have_http_status(:ok)
      expect(job.number_of_vacancies).to eq(2)
      expect(job.location).to eq('Sao Paulo')
    end

    it 'should not update if param is deleted' do
      headhunter = create(:headhunter)
      job = create(:job, headhunter: headhunter)

      patch api_v1_job_path(job), params: { number_of_vacancies: nil,
                                            location: nil }

      expect(response).to have_http_status(412)
      expect(response.body).to include('Vaga nao pode ser atualizada')
    end

    it 'should return status 500 if internal error occur' do
      allow_any_instance_of(Job).to receive(:update).and_raise(ActiveRecord::ActiveRecordError)

      headhunter = create(:headhunter)
      job = create(:job, headhunter: headhunter)

      patch api_v1_job_path(job), params: { number_of_vacancies: 2,
                                            location: 'Sao Paulo' }

      expect(response).to have_http_status(500)
    end
  end

  context 'delete' do
    it 'should delete a job successfully' do
      headhunter = create(:headhunter)
      job = create(:job, headhunter: headhunter)

      login_as headhunter, scope: :headhunter
      delete api_v1_job_path(job)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Vaga excluida com sucesso!')
      expect(Job.count).to eq(0)
    end

    it 'should not be deleted by another headhunter' do
      headhunter = create(:headhunter)
      headhunter2 = create(:headhunter, email: 'headhunter2@test.com')
      job = create(:job, headhunter: headhunter)

      login_as headhunter2, scope: :headhunter
      delete api_v1_job_path(job)

      expect(response).to have_http_status(:forbidden)
      expect(Job.count).to eq(1)
    end

    it 'should return status 500 if internal error occur' do
      allow_any_instance_of(Job).to receive(:destroy).and_raise(ActiveRecord::ActiveRecordError)
      headhunter = create(:headhunter)
      job = create(:job, headhunter: headhunter)

      login_as headhunter, scope: :headhunter

      delete api_v1_job_path(job)
      expect(response).to have_http_status(500)
    end
  end
end
