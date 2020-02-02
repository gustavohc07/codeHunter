# frozen_string_literal: true

require 'rails_helper'

feature 'Headhunter leave message to candidate application' do
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

    login_as headhunter, scope: :headhunter
    visit root_path
    click_on 'Minhas Vagas'
    click_on 'Programador RoR'
    click_on 'Ver Perfil'
    click_on 'Deixar Comentário'

    fill_in 'Comentário', with: 'Quais outras linguagens estão no seu portfolio?'
    click_on 'Enviar'

    expect(current_path).to eq application_path(application)
    expect(page).to have_content('Mensagem enviada com sucesso!')
    expect(page).to have_content('Mensagens')
    expect(page).to have_content('Quais outras linguagens estão no seu portfolio?')
  end

  scenario 'messages linked to job application and candidate' do
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

    another_job = Job.create!(title: 'Programador React',
                              level: 'Senior',
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

    other_candidate = Candidate.create!(email: 'candidate2@test.com', password: '123456')

    Profile.create!(candidate: candidate, name: 'Gustavo', last_name: 'Carvalho',
                    social_name: 'Gustavo', birthday: '20/01/1994', about_yourself: '25 anos, eng civil',
                    university: 'UFU', graduation_course: 'Eng Civil', year_of_graduation: '20/08/2017',
                    company: 'Geometa', role: 'Estagiario', start_date: '20/01/2016', end_date: '20/06/2016',
                    experience_description: 'Auxiliou na obra')

    Profile.create!(candidate: other_candidate, name: 'Thiago', last_name: 'Carvalho',
                    social_name: 'Thiago', birthday: '13/03/1997', about_yourself: 'CC',
                    university: 'UFU', graduation_course: 'CC', year_of_graduation: '20/08/2017',
                    company: 'CodeHunter', role: 'Estagiario', start_date: '20/01/2016', end_date: '20/06/2016',
                    experience_description: 'Auxiliou na infra')
    application = Application.create!(job: job, candidate: candidate, message: 'Ja me candidatei')
    other_application = Application.create!(job: another_job, candidate: other_candidate, message: 'Ja me candidatei 2')
    Message.create!(application: other_application, comment: 'Teste de mensagem')

    login_as headhunter, scope: :headhunter
    visit application_path(application)

    expect(page).not_to have_content(' Mensagens')
    expect(page).not_to have_content('Teste de mensagem')
  end

  scenario 'candidate cannot see messages from other candidate' do
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

    another_job = Job.create!(title: 'Programador React',
                              level: 'Senior',
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

    other_candidate = Candidate.create!(email: 'candidate2@test.com', password: '123456')

    Profile.create!(candidate: candidate, name: 'Gustavo', last_name: 'Carvalho',
                    social_name: 'Gustavo', birthday: '20/01/1994', about_yourself: '25 anos, eng civil',
                    university: 'UFU', graduation_course: 'Eng Civil', year_of_graduation: '20/08/2017',
                    company: 'Geometa', role: 'Estagiario', start_date: '20/01/2016', end_date: '20/06/2016',
                    experience_description: 'Auxiliou na obra')

    Profile.create!(candidate: other_candidate, name: 'Thiago', last_name: 'Carvalho',
                    social_name: 'Thiago', birthday: '13/03/1997', about_yourself: 'CC',
                    university: 'UFU', graduation_course: 'CC', year_of_graduation: '20/08/2017',
                    company: 'CodeHunter', role: 'Estagiario', start_date: '20/01/2016', end_date: '20/06/2016',
                    experience_description: 'Auxiliou na infra')
    Application.create!(job: job, candidate: candidate, message: 'Ja me candidatei')
    other_application = Application.create!(job: another_job, candidate: other_candidate, message: 'Ja me candidatei 2')
    Message.create!(application: other_application, comment: 'Teste de mensagem')

    login_as candidate, scope: :candidate
    visit application_path(other_application)

    expect(current_path).not_to eq application_path(other_application)
    expect(current_path).to eq jobs_path
  end

  scenario 'and message linked to job application' do
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

    another_job = Job.create!(title: 'Programador React',
                              level: 'Senior',
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
    other_application = Application.create!(job: another_job, candidate: candidate, message: 'Ja me candidatei 2')
    Message.create!(application: application, comment: 'Teste de mensagem')

    login_as headhunter, scope: :headhunter
    visit application_path(other_application)

    expect(page).not_to have_content('Mensagens')
    expect(page).not_to have_content('Teste de mensagem')
  end
end
