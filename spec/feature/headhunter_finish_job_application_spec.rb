# frozen_string_literal: true

require 'rails_helper'

feature 'Headhunter can finish job application' do
  scenario 'successfully through proposals page' do
    headhunter = Headhunter.create!(email: 'test@test.com', password: '123456')
    job = Job.create!(title: 'Programador RoR',
                      level: 'Júnior',
                      number_of_vacancies: 1,
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
    Proposal.create!(start_date: '20/01/2020', salary: '3500', benefits: 'Varios', bonus: 'Varios',
                     additional_info: 'Varios', application: application, candidate: candidate, headhunter: headhunter,
                     status: 2, acceptance_message: 'Estou ansioso para começar')

    login_as headhunter, scope: :headhunter
    visit root_path
    click_on 'Minhas Propostas'
    click_on 'Encerrar inscrições'

    expect(page).to have_content('Inscrições para essa vaga foram encerradas')
    expect(page).to have_content('Propostas Enviadas')
    expect(page).to have_content('Gustavo Carvalho')
  end

  scenario 'and headhunter can see his closed jobs' do
    headhunter = Headhunter.create!(email: 'test@test.com', password: '123456')
    Job.create!(title: 'Programador RoR',
                level: 'Júnior',
                number_of_vacancies: 1,
                salary: 3500,
                description: 'Programador Ruby on Rails para atuar em startup',
                abilities: 'CRUD, Git, Ruby, Ruby on Rails, Boa comunicação',
                deadline: '20/01/2020',
                start_date: '02/01/2020',
                location: 'Remoto',
                contract_type: 'CLT',
                headhunter: headhunter,
                status: 1)

    candidate = Candidate.create!(email: 'candidate@test.com', password: '123456')

    Profile.create!(candidate: candidate, name: 'Gustavo', last_name: 'Carvalho',
                    social_name: 'Gustavo', birthday: '20/01/1994', about_yourself: '25 anos, eng civil',
                    university: 'UFU', graduation_course: 'Eng Civil', year_of_graduation: '20/08/2017',
                    company: 'Geometa', role: 'Estagiario', start_date: '20/01/2016', end_date: '20/06/2016',
                    experience_description: 'Auxiliou na obra')

    login_as headhunter, scope: :headhunter
    visit root_path
    click_on 'Minhas Vagas'

    expect(page).to have_content('Processos encerrados')
    expect(page).not_to have_content('Processos em andamento')
    expect(page).not_to have_content('Processos cancelados')
    expect(page).to have_link('Programador RoR')
  end
  scenario 'and headhunter can close job applications direct from his jobs listed ' do
    headhunter = Headhunter.create!(email: 'test@test.com', password: '123456')
    Job.create!(title: 'Programador RoR',
                level: 'Júnior',
                number_of_vacancies: 1,
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

    login_as headhunter, scope: :headhunter
    visit root_path
    click_on 'Minhas Vagas'
    click_on 'Encerrar inscrição'

    expect(page).to have_content('Inscrições para essa vaga foram encerradas')
    expect(page).not_to have_content('Processos em andamento')
    expect(page).to have_content('Processos encerrados')
  end
end
