require "rails_helper"

feature "Headhunter/Codehunter view job applications" do
  scenario "successfully" do
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
    Application.create!(job: job, candidate: other_candidate, message: 'Ja me candidatei 2')

    login_as headhunter, scope: :headhunter
    visit root_path
    click_on 'Minhas Vagas'

    expect(page).to have_content('Meus Processos Seletivos')
    expect(page).to have_content('Processos em andamento')
    expect(page).to have_content('Processos concluidos')
    expect(page).to have_content('Processos cancelados')
    expect(page).to have_link(job.title)
    expect(page).to have_content('Numero de inscritos')
    expect(page).to have_content('2 inscrito')
    expect(page).to have_link(another_job.title)
    expect(page).to have_content('0 inscritos')
  end
  scenario "and cannot view others headhunters/codehunters individual listed jobs" do
    headhunter = Headhunter.create!(email: 'test@test.com', password: '123456')
    another_headhunter = Headhunter.create!(email: 'other@test.com', password: '123456')
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
    Application.create!(job: job, candidate: other_candidate, message: 'Ja me candidatei 2')

    login_as another_headhunter, scope: :headhunter
    visit root_path
    click_on 'Minhas Vagas'

    expect(page).not_to have_content(job.title)
    expect(page).not_to have_content(another_job.title)
  end

  scenario 'and view candidate list' do
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
    Job.create!(title: 'Programador React',
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
    Application.create!(job: job, candidate: other_candidate, message: 'Ja me candidatei 2')

    login_as headhunter, scope: :headhunter
    visit root_path
    click_on 'Minhas Vagas'
    click_on 'Programador RoR'

    expect(page).to have_content('Programador RoR')
    expect(page).to have_content('Candidatos')
    expect(page).to have_content('Nome Completo')
    expect(page).to have_content('Status da Aplicacao')
    expect(page).to have_content('Perfil')
    expect(page).to have_content('Gustavo Carvalho')
    expect(page).to have_content('Thiago Carvalho')
    expect(page).to have_link('Ver Perfil')
  end
  scenario 'and do not see candidates from other job applications' do
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

    login_as headhunter, scope: :headhunter
    visit root_path
    click_on 'Minhas Vagas'
    click_on 'Programador RoR'

    expect(page).to have_content('Gustavo Carvalho')
    expect(page).not_to have_content('Thiago Carvalho')
  end
  scenario 'and can see candidate profile' do
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

    login_as headhunter, scope: :headhunter
    visit root_path
    click_on 'Minhas Vagas'
    click_on 'Programador RoR'
    click_on 'Ver Perfil'

    expect(current_path).to eq application_path(application)
    expect(page).not_to have_content('Bem vindo ao seu perfil!')
    expect(page).not_to have_content('Thiago Carvalho')
  end
  xscenario 'and change application status' do

  end
end