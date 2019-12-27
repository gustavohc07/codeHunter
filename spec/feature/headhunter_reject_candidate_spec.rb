require "rails_helper"

feature "Headhunter reject candidate application" do
  scenario "successfully" do
    headhunter = Headhunter.create!(email: "test@test.com", password: "123456")
    job = Job.create!(title: "Programador RoR",
                      level: "Senior",
                      number_of_vacancies: 4,
                      salary: 3500,
                      description: "Programador Ruby on Rails para atuar em startup",
                      abilities: "CRUD, Git, Ruby, Ruby on Rails, Boa comunicação",
                      deadline: "20/01/2020",
                      start_date: "02/01/2020",
                      location: "Remoto",
                      contract_type: "CLT",
                      headhunter: headhunter)

    candidate = Candidate.create!(email: "candidate@test.com", password: "123456")

    Profile.create!(candidate: candidate, name: "Gustavo", last_name: "Carvalho",
                    social_name: "Gustavo", birthday: "20/01/1994", about_yourself: "25 anos, eng civil",
                    university: "UFU", graduation_course: "Eng Civil", year_of_graduation: "20/08/2017",
                    company: "Geometa", role: "Estagiario", start_date: "20/01/2016", end_date: "20/06/2016",
                    experience_description: "Auxiliou na obra")
    Application.create!(job: job, candidate: candidate, message: "Ja me candidatei")
    
    login_as headhunter, scope: :headhunter
    visit root_path
    visit job_myjobs_path(headhunter)
    click_on 'Programador RoR'
    click_on 'Ver Perfil'
    click_on 'Cancelar essa candidatura'

    fill_in 'Mensagem de Feedback', with: 'Infelizmente procuramos alguém do setor de TI'
    click_on 'Enviar'

    expect(page).to have_content('Que pena que esse candidato não atendeu às suas expectativas :(')
    expect(page).to have_content('Infelizmente procuramos alguém do setor de TI')
  end

  scenario "and candidate cannot cancel application to apply again" do
    headhunter = Headhunter.create!(email: "test@test.com", password: "123456")
    job = Job.create!(title: "Programador RoR",
                      level: "Senior",
                      number_of_vacancies: 4,
                      salary: 3500,
                      description: "Programador Ruby on Rails para atuar em startup",
                      abilities: "CRUD, Git, Ruby, Ruby on Rails, Boa comunicação",
                      deadline: "20/01/2020",
                      start_date: "02/01/2020",
                      location: "Remoto",
                      contract_type: "CLT",
                      headhunter: headhunter)

    candidate = Candidate.create!(email: "candidate@test.com", password: "123456")

    Profile.create!(candidate: candidate, name: "Gustavo", last_name: "Carvalho",
                    social_name: "Gustavo", birthday: "20/01/1994", about_yourself: "25 anos, eng civil",
                    university: "UFU", graduation_course: "Eng Civil", year_of_graduation: "20/08/2017",
                    company: "Geometa", role: "Estagiario", start_date: "20/01/2016", end_date: "20/06/2016",
                    experience_description: "Auxiliou na obra")
    application = Application.create!(job: job, candidate: candidate, message: "Ja me candidatei", status: 1)
    Feedback.create!(application: application, feedback_message: 'Agradecemos sua candidadura. Infelizmente nao poderemos prosseguir o processo...')

    login_as candidate, scope: :candidate

    visit root_path
    click_on 'Minhas Candidaturas'
    click_on 'Programador RoR'

    expect(page).not_to have_content('Cancelar Inscrição')
  end
  scenario 'and cannot apply again' do
    headhunter = Headhunter.create!(email: "test@test.com", password: "123456")
    job = Job.create!(title: "Programador RoR",
                      level: "Senior",
                      number_of_vacancies: 4,
                      salary: 3500,
                      description: "Programador Ruby on Rails para atuar em startup",
                      abilities: "CRUD, Git, Ruby, Ruby on Rails, Boa comunicação",
                      deadline: "20/01/2020",
                      start_date: "02/01/2020",
                      location: "Remoto",
                      contract_type: "CLT",
                      headhunter: headhunter)

    candidate = Candidate.create!(email: "candidate@test.com", password: "123456")

    Profile.create!(candidate: candidate, name: "Gustavo", last_name: "Carvalho",
                    social_name: "Gustavo", birthday: "20/01/1994", about_yourself: "25 anos, eng civil",
                    university: "UFU", graduation_course: "Eng Civil", year_of_graduation: "20/08/2017",
                    company: "Geometa", role: "Estagiario", start_date: "20/01/2016", end_date: "20/06/2016",
                    experience_description: "Auxiliou na obra")
    application = Application.create!(job: job, candidate: candidate, message: "Ja me candidatei", status: 1)
    Feedback.create!(application: application, feedback_message: 'Agradecemos sua candidadura. Infelizmente nao poderemos prosseguir o processo...')

    login_as candidate, scope: :candidate

    visit root_path
    click_on 'Vagas'
    click_on 'Ver detalhes'
    click_on 'Aplicar para vaga'

    expect(page).to have_content('Voce já está inscrito nessa vaga')
  end
  scenario 'and headhunter must sent a feedback message' do
    headhunter = Headhunter.create!(email: "test@test.com", password: "123456")
    job = Job.create!(title: "Programador RoR",
                      level: "Senior",
                      number_of_vacancies: 4,
                      salary: 3500,
                      description: "Programador Ruby on Rails para atuar em startup",
                      abilities: "CRUD, Git, Ruby, Ruby on Rails, Boa comunicação",
                      deadline: "20/01/2020",
                      start_date: "02/01/2020",
                      location: "Remoto",
                      contract_type: "CLT",
                      headhunter: headhunter)

    candidate = Candidate.create!(email: "candidate@test.com", password: "123456")

    Profile.create!(candidate: candidate, name: "Gustavo", last_name: "Carvalho",
                    social_name: "Gustavo", birthday: "20/01/1994", about_yourself: "25 anos, eng civil",
                    university: "UFU", graduation_course: "Eng Civil", year_of_graduation: "20/08/2017",
                    company: "Geometa", role: "Estagiario", start_date: "20/01/2016", end_date: "20/06/2016",
                    experience_description: "Auxiliou na obra")
    Application.create!(job: job, candidate: candidate, message: "Ja me candidatei")

    login_as headhunter, scope: :headhunter
    visit root_path
    visit job_myjobs_path(headhunter)
    click_on 'Programador RoR'
    click_on 'Ver Perfil'
    click_on 'Cancelar essa candidatura'
    click_on 'Enviar'

    expect(page).to have_content('Poxa, deixe um feedback para o candidato!')
    expect(page).to have_content('Mensagem de Feedback não pode ficar em branco')
  end
  scenario 'and candidate can view headhunter rejection feedback' do
    headhunter = Headhunter.create!(email: "test@test.com", password: "123456")
    job = Job.create!(title: "Programador RoR",
                      level: "Senior",
                      number_of_vacancies: 4,
                      salary: 3500,
                      description: "Programador Ruby on Rails para atuar em startup",
                      abilities: "CRUD, Git, Ruby, Ruby on Rails, Boa comunicação",
                      deadline: "20/01/2020",
                      start_date: "02/01/2020",
                      location: "Remoto",
                      contract_type: "CLT",
                      headhunter: headhunter)

    candidate = Candidate.create!(email: "candidate@test.com", password: "123456")

    Profile.create!(candidate: candidate, name: "Gustavo", last_name: "Carvalho",
                    social_name: "Gustavo", birthday: "20/01/1994", about_yourself: "25 anos, eng civil",
                    university: "UFU", graduation_course: "Eng Civil", year_of_graduation: "20/08/2017",
                    company: "Geometa", role: "Estagiario", start_date: "20/01/2016", end_date: "20/06/2016",
                    experience_description: "Auxiliou na obra")
    application = Application.create!(job: job, candidate: candidate, message: "Ja me candidatei", status: 1)
    Feedback.create!(application: application, feedback_message: 'Agradecemos sua candidadura. Infelizmente nao poderemos prosseguir o processo...')

    login_as candidate, scope: :candidate

    visit root_path
    click_on 'Minhas Candidaturas'
    click_on 'Programador RoR'

    expect(page).to have_content('Mensagem do recrutador')
    expect(page).to have_content('Agradecemos sua candidadura. Infelizmente nao poderemos prosseguir o processo...')
  end
end