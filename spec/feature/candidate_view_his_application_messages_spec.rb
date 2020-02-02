# frozen_string_literal: true

require 'rails_helper'

feature 'Candidate view his application messages' do
  scenario 'successfully' do
    headhunter = Headhunter.create!(email: 'test@test.com', password: '123456')
    job = Job.create!(title: 'Programador RoR',
                      level: 'Júnior',
                      number_of_vacancies: 4,
                      salary: 3500,
                      description: 'Programador Ruby on Rails para atuar em startup',
                      abilities: 'CRUD, Git, Ruby, Ruby on Rails, Boa comunicação',
                      deadline: '20/01/2020',
                      start_date: '02/01/2020',
                      location: 'Remoto',
                      contract_type: 'CLT',
                      headhunter: headhunter)

    candidate = Candidate.create!(email: 'candidate@test.com', password: '123456')

    Profile.create!(candidate: candidate, name: 'Gustavo', last_name: 'Carvalho',
                    social_name: 'Gustavo', birthday: '20/01/1994', about_yourself: '25 anos, eng civil',
                    university: 'UFU', graduation_course: 'Eng Civil', year_of_graduation: '20/08/2017',
                    company: 'Geometa', role: 'Estagiario', start_date: '20/01/2016', end_date: '20/06/2016',
                    experience_description: 'Auxiliou na obra')

    application = Application.create!(job: job, candidate: candidate, message: 'Ja me candidatei')
    Message.create!(application: application, comment: 'Teste de mensagem')

    login_as candidate, scope: :candidate
    visit application_path(application)

    expect(page).to have_content('Mensagens')
    expect(page).to have_content('Teste de mensagem')
  end
end
