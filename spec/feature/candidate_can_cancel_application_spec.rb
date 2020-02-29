require 'rails_helper'

feature 'Candidate can cancel job application' do
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
    candidate = Candidate.create!(email: 'candidate@test.com',
                                  password: '123456')
    Profile.create!(candidate: candidate, name: 'Gustavo',
                    last_name: 'Carvalho',
                    social_name: 'Gustavo', birthday: '20/01/1994',
                    about_yourself: '25 anos, eng civil',
                    university: 'UFU', graduation_course: 'Eng Civil',
                    year_of_graduation: '20/08/2017',
                    company: 'Geometa', role: 'Estagiario',
                    start_date: '20/01/2016', end_date: '20/06/2016',
                    experience_description: 'Auxiliou na obra')
    application = Application.create!(job: job, candidate: candidate, message: 'Ja me candidatei')

    login_as candidate, scope: :candidate
    visit applications_path
    click_on 'Programador RoR'
    click_on 'Cancelar Inscrição'

    expect(current_path).to eq applications_path
    expect(page).to have_content('Poxa! Que pena que você não poderá participar desse processo! :(')
    expect(page).not_to have_content('Programador RoR')
  end

  scenario 'and can still apply to it' do
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

    login_as candidate, scope: :candidate
    visit applications_path
    click_on 'Programador RoR'
    click_on 'Cancelar Inscrição'
    visit jobs_path
    click_on 'Ver detalhes'
    click_on 'Aplicar para vaga'
    click_on 'Candidatar!'

    expect(current_path).to eq application_path(application)
    expect(page).to have_content('Programador RoR')
    expect(page).to have_content('Mensagem ao CodeHunter:')
  end

  scenario 'and cancelation do not cancel other applications' do
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
    other_job = Job.create!(title: 'Programador React',
                            level: 'Senior',
                            number_of_vacancies: 20,
                            salary: 1000,
                            description: 'Programador Ruby on Rails para atuar em startup',
                            abilities: 'CRUD, Git, Ruby, Ruby on Rails, Boa comunicação',
                            deadline: '20/01/2020',
                            start_date: '02/01/2020', location: 'Remoto',
                            contract_type: 'CLT',
                            headhunter: headhunter)

    candidate = Candidate.create!(email: 'candidate@test.com', password: '123456')

    Profile.create!(candidate: candidate, name: 'Gustavo',
                    last_name: 'Carvalho',
                    social_name: 'Gustavo', birthday: '20/01/1994',
                    about_yourself: '25 anos, eng civil',
                    university: 'UFU', graduation_course: 'Eng Civil',
                    year_of_graduation: '20/08/2017',
                    company: 'Geometa', role: 'Estagiario',
                    start_date: '20/01/2016', end_date: '20/06/2016',
                    experience_description: 'Auxiliou na obra')
    Application.create!(job: job,
                        candidate: candidate,
                        message: 'Ja me candidatei')
    Application.create!(job: other_job,
                        candidate: candidate,
                        message: 'Ja me candidatei')

    login_as candidate, scope: :candidate
    visit applications_path
    click_on 'Programador RoR'
    click_on 'Cancelar Inscrição'

    expect(page).not_to have_content('Programador RoR')
    expect(page).to have_content('Programador React')
  end

  scenario 'and receive an cancelation email' do
    mailer_spy = class_spy(JobApplicationMailer)
    stub_const('JobApplicationMailer', mailer_spy)
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
    candidate = Candidate.create!(email: 'candidate@test.com',
                                  password: '123456')
    Profile.create!(candidate: candidate, name: 'Gustavo',
                    last_name: 'Carvalho',
                    social_name: 'Gustavo', birthday: '20/01/1994',
                    about_yourself: '25 anos, eng civil',
                    university: 'UFU', graduation_course: 'Eng Civil',
                    year_of_graduation: '20/08/2017',
                    company: 'Geometa', role: 'Estagiario',
                    start_date: '20/01/2016', end_date: '20/06/2016',
                    experience_description: 'Auxiliou na obra')
    Application.create!(job: job, candidate: candidate,
                        message: 'Ja me candidatei')

    application = Application.last

    login_as candidate, scope: :candidate
    visit applications_path
    click_on 'Programador RoR'
    click_on 'Cancelar Inscrição'

    expect(JobApplicationMailer).to have_received(:cancelation_email)
      .with(application.id)
    expect(Application.all.count).to eq(0)
  end
end
