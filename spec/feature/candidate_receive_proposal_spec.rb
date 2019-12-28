require "rails_helper"

feature "Candidate receive job application proposal" do
  scenario "successfully view his/her proposals" do
    headhunter = Headhunter.create!(email: "test@test.com", password: "123456")
    job = Job.create!(title: "Programador RoR",
                      level: "Júnior",
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

    application = Application.create!(job: job, candidate: candidate, message: "Ja me candidatei")
    Proposal.create!(start_date: "20/01/2020", salary: "3500", benefits: "Varios", bonus: "Varios",
                     additional_info: "Varios", application: application)

    login_as candidate, scope: :candidate
    visit root_path
    click_on "Minhas Propostas"


    expect(page).to have_content("Propostas Recebidas")
    expect(page).to have_link("Programador RoR")
    expect(page).to have_link("Aceitar")
    expect(page).to have_link("Recusar")
  end

  scenario "and successfully view details of proposal" do
    headhunter = Headhunter.create!(email: "test@test.com", password: "123456")
    job = Job.create!(title: "Programador RoR",
                      level: "Júnior",
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

    application = Application.create!(job: job, candidate: candidate, message: "Ja me candidatei")
    Proposal.create!(start_date: "20/01/2020", salary: "3500", benefits: "VR, VA, Saúde",
                     bonus: "PLR e bônus de desempenho",
                     additional_info: "Expediente mais curto toda sexta feira",
                     application: application)

    login_as candidate, scope: :candidate
    visit root_path
    click_on "Minhas Propostas"
    click_on "Programador RoR"

    expect(page).to have_content("Proposta para Gustavo Carvalho")
    expect(page).to have_content("Início")
    expect(page).to have_content("20/01/2020")
    expect(page).to have_content("Salário")
    expect(page).to have_content("R$ 3.500,00")
    expect(page).to have_content("Benefícios")
    expect(page).to have_content("VR, VA, Saúde")
    expect(page).to have_content("Bônus")
    expect(page).to have_content("PLR e bônus de desempenho")
    expect(page).to have_content("Outras Informações")
    expect(page).to have_content("Expediente mais curto toda sexta feira")
    expect(page).to have_link("Voltar")
    expect(page).to have_link("Aceitar")
    expect(page).to have_link("Recusar")
  end

  scenario "and can see more than one proposal" do
    headhunter = Headhunter.create!(email: "test@test.com", password: "123456")
    job = Job.create!(title: "Programador RoR",
                      level: "Júnior",
                      number_of_vacancies: 4,
                      salary: 3500,
                      description: "Programador Ruby on Rails para atuar em startup",
                      abilities: "CRUD, Git, Ruby, Ruby on Rails, Boa comunicação",
                      deadline: "20/01/2020",
                      start_date: "02/01/2020",
                      location: "Remoto",
                      contract_type: "CLT",
                      headhunter: headhunter)
    another_job = Job.create!(title: "Programador React",
                              level: "Júnior",
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

    application = Application.create!(job: job, candidate: candidate, message: "Ja me candidatei")
    another_application = Application.create!(job: another_job, candidate: candidate, message: "Outra candidatura")
    Proposal.create!(start_date: "20/01/2020", salary: "3500", benefits: "VR, VA, Saúde",
                     bonus: "PLR e bônus de desempenho",
                     additional_info: "Expediente mais curto toda sexta feira",
                     application: application)
    Proposal.create!(start_date: "25/03/2020", salary: "4500", benefits: "VR, VA, Saúde",
                     bonus: "PLR e bônus de desempenho",
                     additional_info: "Expediente mais curto toda sexta feira",
                     application: another_application)

    login_as candidate, scope: :candidate
    visit root_path
    click_on "Minhas Propostas"

    expect(page).to have_content("Programador RoR")
    expect(page).to have_content("Programador React")
  end

  scenario "and there are no proposals" do
    headhunter = Headhunter.create!(email: "test@test.com", password: "123456")
    job = Job.create!(title: "Programador RoR",
                      level: "Júnior",
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

    login_as candidate, scope: :candidate
    visit root_path
    click_on "Minhas Propostas"

    expect(page).to have_content("Não há propostas, ainda, para as suas candidaturas.")
  end

  scenario "and can't see other's proposals" do
    headhunter = Headhunter.create!(email: "test@test.com", password: "123456")
    job = Job.create!(title: "Programador RoR",
                      level: "Júnior",
                      number_of_vacancies: 4,
                      salary: 3500,
                      description: "Programador Ruby on Rails para atuar em startup",
                      abilities: "CRUD, Git, Ruby, Ruby on Rails, Boa comunicação",
                      deadline: "20/01/2020",
                      start_date: "02/01/2020",
                      location: "Remoto",
                      contract_type: "CLT",
                      headhunter: headhunter)
    another_job = Job.create!(title: "Programador React",
                              level: "Júnior",
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
    other_candidate = Candidate.create!(email: "candidate2@test.com", password: "123456")

    Profile.create!(candidate: candidate, name: "Gustavo", last_name: "Carvalho",
                    social_name: "Gustavo", birthday: "20/01/1994", about_yourself: "25 anos, eng civil",
                    university: "UFU", graduation_course: "Eng Civil", year_of_graduation: "20/08/2017",
                    company: "Geometa", role: "Estagiario", start_date: "20/01/2016", end_date: "20/06/2016",
                    experience_description: "Auxiliou na obra")

    application = Application.create!(job: job, candidate: candidate, message: "Ja me candidatei")
    another_application = Application.create!(job: another_job, candidate: candidate, message: "Outra candidatura")
    Proposal.create!(start_date: "20/01/2020", salary: "3500", benefits: "VR, VA, Saúde",
                     bonus: "PLR e bônus de desempenho",
                     additional_info: "Expediente mais curto toda sexta feira",
                     application: application)
    Proposal.create!(start_date: "25/03/2020", salary: "4500", benefits: "VR, VA, Saúde",
                     bonus: "PLR e bônus de desempenho",
                     additional_info: "Expediente mais curto toda sexta feira",
                     application: another_application)

    login_as other_candidate, scope: :candidate
    visit root_path
    click_on "Minhas Propostas"

    expect(page).not_to have_content("Programador RoR")
    expect(page).not_to have_content("Programador React")
    expect(page).to have_content("Não há propostas, ainda, para as suas candidaturas.")
  end

  scenario "and can see in job applications if received a proposal" do
    headhunter = Headhunter.create!(email: "test@test.com", password: "123456")
    job = Job.create!(title: "Programador RoR",
                      level: "Júnior",
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

    application = Application.create!(job: job, candidate: candidate, message: "Ja me candidatei")
    Proposal.create!(start_date: "20/01/2020", salary: "3500", benefits: "Varios", bonus: "Varios",
                     additional_info: "Varios", application: application)

    login_as candidate, scope: :candidate
    visit root_path
    click_on "Minhas Candidaturas"

    expect(page).to have_content("Você possui uma proposta para essa inscrição!")
    expect(page).to have_link("Ver Proposta")
  end

  scenario "and can't see proposal in job applications if there aren't any" do
    headhunter = Headhunter.create!(email: "test@test.com", password: "123456")
    job = Job.create!(title: "Programador RoR",
                      level: "Júnior",
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

    login_as candidate, scope: :candidate
    visit root_path
    click_on "Minhas Candidaturas"


    expect(page).not_to have_content("Você possui uma proposta para essa inscrição!")
    expect(page).not_to have_link("Ver Proposta")
  end

  scenario "and can visit proposal from job applications page" do
    headhunter = Headhunter.create!(email: "test@test.com", password: "123456")
    job = Job.create!(title: "Programador RoR",
                      level: "Júnior",
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

    application = Application.create!(job: job, candidate: candidate, message: "Ja me candidatei")
    Proposal.create!(start_date: "20/01/2020", salary: "3500", benefits: "VR, VA, Saúde",
                     bonus: "PLR e bônus de desempenho",
                     additional_info: "Expediente mais curto toda sexta feira",
                     application: application)

    login_as candidate, scope: :candidate
    visit root_path
    click_on "Minhas Candidaturas"
    click_on "Ver Proposta"

    expect(page).to have_content("Proposta para Gustavo Carvalho")
    expect(page).to have_content("Início")
    expect(page).to have_content("20/01/2020")
    expect(page).to have_content("Salário")
    expect(page).to have_content("R$ 3.500,00")
    expect(page).to have_content("Benefícios")
    expect(page).to have_content("VR, VA, Saúde")
    expect(page).to have_content("Bônus")
    expect(page).to have_content("PLR e bônus de desempenho")
    expect(page).to have_content("Outras Informações")
    expect(page).to have_content("Expediente mais curto toda sexta feira")
    expect(page).to have_link("Voltar")
    expect(page).to have_link("Aceitar")
    expect(page).to have_link("Recusar")
  end

  scenario "and can see job proposal in job application details" do
    headhunter = Headhunter.create!(email: "test@test.com", password: "123456")
    job = Job.create!(title: "Programador RoR",
                      level: "Júnior",
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

    application = Application.create!(job: job, candidate: candidate, message: "Ja me candidatei")
    Proposal.create!(start_date: "20/01/2020", salary: "3500", benefits: "VR, VA, Saúde",
                     bonus: "PLR e bônus de desempenho",
                     additional_info: "Expediente mais curto toda sexta feira",
                     application: application)

    login_as candidate, scope: :candidate
    visit root_path
    click_on "Minhas Candidaturas"
    click_on "Programador RoR"

    expect(page).to have_content("Você tem uma proposta para essa candidatura!")
    expect(page).to have_link("Ver Proposta")
  end

  scenario "and cannot see links if there are no proposals yet" do
    headhunter = Headhunter.create!(email: "test@test.com", password: "123456")
    job = Job.create!(title: "Programador RoR",
                      level: "Júnior",
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

    login_as candidate, scope: :candidate
    visit root_path
    click_on "Minhas Candidaturas"
    click_on "Programador RoR"

    expect(page).not_to have_content("Você tem uma proposta para essa candidatura!")
    expect(page).not_to have_link("Ver Proposta")
  end
  context "and accept job proposal" do
    scenario "accept from proposal details page" do
      headhunter = Headhunter.create!(email: "test@test.com", password: "123456")
      job = Job.create!(title: "Programador RoR",
                        level: "Júnior",
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

      application = Application.create!(job: job, candidate: candidate, message: "Ja me candidatei")
      Proposal.create!(start_date: "20/01/2020", salary: "3500", benefits: "Varios", bonus: "Varios",
                       additional_info: "Varios", application: application)

      login_as candidate, scope: :candidate
      visit root_path
      click_on "Minhas Propostas"
      click_on "Programador RoR"
      click_on "Aceitar"

      fill_in "Mensagem ao recrutador", with: "Estou ansioso para comecar!"
      click_on "Enviar"

      expect(current_path).to eq proposals_path
      expect(page).to have_content("Oba! Ficamos felizes que você tenha encontrado a sua oportunidade!")
      expect(page).to have_content("Aceito")
    end

    scenario "and all other proposals got refused" do
      headhunter = Headhunter.create!(email: "test@test.com", password: "123456")
      job = Job.create!(title: "Programador RoR",
                        level: "Júnior",
                        number_of_vacancies: 4,
                        salary: 3500,
                        description: "Programador Ruby on Rails para atuar em startup",
                        abilities: "CRUD, Git, Ruby, Ruby on Rails, Boa comunicação",
                        deadline: "20/01/2020",
                        start_date: "02/01/2020",
                        location: "Remoto",
                        contract_type: "CLT",
                        headhunter: headhunter)
      another_job = Job.create!(title: "Programador React",
                                level: "Júnior",
                                number_of_vacancies: 4,
                                salary: 3500,
                                description: "Programador React para atuar em startup",
                                abilities: "CRUD, Git, Ruby, Ruby on Rails, Boa comunicação",
                                deadline: "20/01/2020",
                                start_date: "02/01/2020",
                                location: "Remoto",
                                contract_type: "CLT",
                                headhunter: headhunter)

      yet_another_job = Job.create!(title: "Programador PHP",
                                    level: "Senior",
                                    number_of_vacancies: 4,
                                    salary: 3500,
                                    description: "Programador PHP para atuar em startup",
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

      application = Application.create!(job: job, candidate: candidate, message: "Ja me candidatei")
      another_application = Application.create!(job: another_job, candidate: candidate, message: "Outra candidatura")
      yet_another_application = Application.create!(job: yet_another_job, candidate: candidate, message: "Outra candidatura")

      Proposal.create!(start_date: "20/01/2020", salary: "3500", benefits: "VR, VA, Saúde",
                       bonus: "PLR e bônus de desempenho",
                       additional_info: "Expediente mais curto toda sexta feira",
                       application: application)
      Proposal.create!(start_date: "25/03/2020", salary: "4500", benefits: "VR, VA, Saúde",
                       bonus: "PLR e bônus de desempenho",
                       additional_info: "Expediente mais curto toda sexta feira",
                       application: another_application)
      Proposal.create!(start_date: "25/03/2020", salary: "4500", benefits: "VR, VA, Saúde",
                       bonus: "PLR e bônus de desempenho",
                       additional_info: "Expediente mais curto toda sexta feira",
                       application: yet_another_application)

      login_as candidate, scope: :candidate
      visit root_path
      click_on "Minhas Propostas"
      click_on "Programador RoR"
      click_on "Aceitar"

      fill_in "Mensagem ao recrutador", with: "Estou ansioso para comecar!"
      click_on "Enviar"

      expect(current_path).to eq proposals_path
      expect(page).to have_content("Oba! Ficamos felizes que você tenha encontrado a sua oportunidade!")
      expect(page).to have_content("Aceito")
      expect(page).to have_content("Recusado")
    end

    scenario "and do not decline other's offers" do
      headhunter = Headhunter.create!(email: "test@test.com", password: "123456")
      job = Job.create!(title: "Programador RoR",
                        level: "Júnior",
                        number_of_vacancies: 4,
                        salary: 3500,
                        description: "Programador Ruby on Rails para atuar em startup",
                        abilities: "CRUD, Git, Ruby, Ruby on Rails, Boa comunicação",
                        deadline: "20/01/2020",
                        start_date: "02/01/2020",
                        location: "Remoto",
                        contract_type: "CLT",
                        headhunter: headhunter)

      another_job = Job.create!(title: "Programador React",
                                level: "Júnior",
                                number_of_vacancies: 4,
                                salary: 3500,
                                description: "Programador React para atuar em startup",
                                abilities: "CRUD, Git, Ruby, Ruby on Rails, Boa comunicação",
                                deadline: "20/01/2020",
                                start_date: "02/01/2020",
                                location: "Remoto",
                                contract_type: "CLT",
                                headhunter: headhunter)

      candidate = Candidate.create!(email: "candidate@test.com", password: "123456")
      other_candidate = Candidate.create!(email: "candidate2@test.com", password: "123456")

      Profile.create!(candidate: candidate, name: "Gustavo", last_name: "Carvalho",
                      social_name: "Gustavo", birthday: "20/01/1994", about_yourself: "25 anos, eng civil",
                      university: "UFU", graduation_course: "Eng Civil", year_of_graduation: "20/08/2017",
                      company: "Geometa", role: "Estagiario", start_date: "20/01/2016", end_date: "20/06/2016",
                      experience_description: "Auxiliou na obra")

      application = Application.create!(job: job, candidate: candidate, message: "Ja me candidatei")
      another_application = Application.create!(job: another_job, candidate: other_candidate, message: "Outra candidatura")
      Proposal.create!(start_date: "25/03/2020", salary: "4500", benefits: "VR, VA, Saúde",
                       bonus: "PLR e bônus de desempenho",
                       additional_info: "Expediente mais curto toda sexta feira",
                       application: another_application)
      Proposal.create!(start_date: "20/01/2020", salary: "3500", benefits: "Varios", bonus: "Varios",
                       additional_info: "Varios", application: application)

      login_as candidate, scope: :candidate
      visit root_path
      click_on "Minhas Propostas"
      click_on "Programador RoR"
      click_on "Aceitar"

      fill_in "Mensagem ao recrutador", with: "Estou ansioso para comecar!"
      click_on "Enviar"

      login_as other_candidate, scope: :candidate
      visit root_path
      click_on "Minhas Propostas"

      expect(page).to have_content('Programador React')
      expect(page).to have_content('Pendente')

    end

    scenario "and can view acceptance message" do
      headhunter = Headhunter.create!(email: "test@test.com", password: "123456")
      job = Job.create!(title: "Programador RoR",
                        level: "Júnior",
                        number_of_vacancies: 4,
                        salary: 3500,
                        description: "Programador Ruby on Rails para atuar em startup",
                        abilities: "CRUD, Git, Ruby, Ruby on Rails, Boa comunicação",
                        deadline: "20/01/2020",
                        start_date: "02/01/2020",
                        location: "Remoto",
                        contract_type: "CLT",
                        headhunter: headhunter)

      another_job = Job.create!(title: "Programador React",
                                level: "Júnior",
                                number_of_vacancies: 4,
                                salary: 3500,
                                description: "Programador React para atuar em startup",
                                abilities: "CRUD, Git, Ruby, Ruby on Rails, Boa comunicação",
                                deadline: "20/01/2020",
                                start_date: "02/01/2020",
                                location: "Remoto",
                                contract_type: "CLT",
                                headhunter: headhunter)

      candidate = Candidate.create!(email: "candidate@test.com", password: "123456")
      other_candidate = Candidate.create!(email: "candidate2@test.com", password: "123456")

      Profile.create!(candidate: candidate, name: "Gustavo", last_name: "Carvalho",
                      social_name: "Gustavo", birthday: "20/01/1994", about_yourself: "25 anos, eng civil",
                      university: "UFU", graduation_course: "Eng Civil", year_of_graduation: "20/08/2017",
                      company: "Geometa", role: "Estagiario", start_date: "20/01/2016", end_date: "20/06/2016",
                      experience_description: "Auxiliou na obra")

      application = Application.create!(job: job, candidate: candidate, message: "Ja me candidatei")
      another_application = Application.create!(job: another_job, candidate: other_candidate, message: "Outra candidatura")
      Proposal.create!(start_date: "25/03/2020", salary: "4500", benefits: "VR, VA, Saúde",
                       bonus: "PLR e bônus de desempenho",
                       additional_info: "Expediente mais curto toda sexta feira",
                       application: another_application)
      Proposal.create!(start_date: "20/01/2020", salary: "3500", benefits: "Varios", bonus: "Varios",
                       additional_info: "Varios", application: application)

      login_as candidate, scope: :candidate
      visit root_path
      click_on "Minhas Propostas"
      click_on "Programador RoR"
      click_on "Aceitar"

      fill_in "Mensagem ao recrutador", with: "Estou ansioso para comecar!"
      click_on "Enviar"
      click_on 'Programador RoR'

      expect(page).to have_content('Mensagem ao CodeHunter:')
      expect(page).to have_content('Estou ansioso para comecar!')
    end

    scenario "accept from proposals page" do
      headhunter = Headhunter.create!(email: "test@test.com", password: "123456")
      job = Job.create!(title: "Programador RoR",
                        level: "Júnior",
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

      application = Application.create!(job: job, candidate: candidate, message: "Ja me candidatei")
      Proposal.create!(start_date: "20/01/2020", salary: "3500", benefits: "Varios", bonus: "Varios",
                       additional_info: "Varios", application: application)

      login_as candidate, scope: :candidate
      visit root_path
      click_on "Minhas Propostas"
      click_on "Aceitar"
      fill_in "Mensagem ao recrutador", with: "Estou ansioso para comecar!"
      click_on "Enviar"

      expect(current_path).to eq proposals_path
      expect(page).to have_content("Oba! Ficamos felizes que você tenha encontrado a sua oportunidade!")
      expect(page).to have_content("Aceito")
    end
  end

  context "and refuse job proposal" do
    scenario 'reject from proposal details page' do
      headhunter = Headhunter.create!(email: "test@test.com", password: "123456")
      job = Job.create!(title: "Programador RoR",
                        level: "Júnior",
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

      application = Application.create!(job: job, candidate: candidate, message: "Ja me candidatei")
      Proposal.create!(start_date: "20/01/2020", salary: "3500", benefits: "Varios", bonus: "Varios",
                       additional_info: "Varios", application: application)

      login_as candidate, scope: :candidate
      visit root_path
      click_on "Minhas Propostas"
      click_on "Programador RoR"
      click_on "Recusar"

      fill_in "Mensagem ao recrutador", with: "Infelizmente nao poderei comecar na data prevista"
      click_on "Enviar"

      expect(current_path).to eq proposals_path
      expect(page).to have_content("Que pena que não poderá aceitar essa proposta. Mas fique tranquilo, várias outras aparecerão :)")
      expect(page).to have_content("Recusado")
    end

    scenario 'reject from proposals page' do
      headhunter = Headhunter.create!(email: "test@test.com", password: "123456")
      job = Job.create!(title: "Programador RoR",
                        level: "Júnior",
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

      application = Application.create!(job: job, candidate: candidate, message: "Ja me candidatei")
      Proposal.create!(start_date: "20/01/2020", salary: "3500", benefits: "Varios", bonus: "Varios",
                       additional_info: "Varios", application: application)

      login_as candidate, scope: :candidate
      visit root_path
      click_on "Minhas Propostas"
      click_on "Recusar"

      fill_in "Mensagem ao recrutador", with: "Infelizmente nao poderei comecar na data prevista"
      click_on "Enviar"

      expect(current_path).to eq proposals_path
      expect(page).to have_content("Que pena que não poderá aceitar essa proposta. Mas fique tranquilo, várias outras aparecerão :)")
      expect(page).to have_content("Recusado")
    end

    scenario 'and can view reject message' do
      headhunter = Headhunter.create!(email: "test@test.com", password: "123456")
      job = Job.create!(title: "Programador RoR",
                        level: "Júnior",
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

      application = Application.create!(job: job, candidate: candidate, message: "Ja me candidatei")
      Proposal.create!(start_date: "20/01/2020", salary: "3500", benefits: "Varios", bonus: "Varios",
                       additional_info: "Varios", application: application)

      login_as candidate, scope: :candidate
      visit root_path
      click_on "Minhas Propostas"
      click_on "Recusar"

      fill_in "Mensagem ao recrutador", with: "Infelizmente nao poderei comecar na data prevista"
      click_on "Enviar"
      click_on 'Programador RoR'

      expect(page).to have_content('Mensagem ao CodeHunter:')
      expect(page).to have_content('Infelizmente nao poderei comecar na data prevista')
    end
  end
end