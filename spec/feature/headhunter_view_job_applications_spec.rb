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
    application = Application.create!(job: job, candidate: candidate, message: 'Ja me candidatei')
    other_application = Application.create!(job: job, candidate: other_candidate, message: 'Ja me candidatei 2')

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
    application = Application.create!(job: job, candidate: candidate, message: 'Ja me candidatei')
    other_application = Application.create!(job: job, candidate: other_candidate, message: 'Ja me candidatei 2')

    login_as another_headhunter, scope: :headhunter
    visit root_path
    click_on 'Minhas Vagas'

    expect(page).not_to have_content(job.title)
    expect(page).not_to have_content(another_job.title)
  end
end