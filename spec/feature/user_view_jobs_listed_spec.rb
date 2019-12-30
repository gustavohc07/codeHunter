require 'rails_helper'

feature 'User view jobs listed' do
  context 'non registered' do
    scenario 'successfully without any job listed' do
      visit root_path
      click_on 'Vagas'

      expect(current_path).to eq jobs_path
      expect(page).to have_content('Que pena! Não há vagas públicas listadas no momento.')

      expect(page).not_to have_content('Não há vagas públicas cadastradas! Que tal ser o primeiro? :)')
      expect(page).not_to have_link('clicar aqui')
      expect(page).not_to have_link('Minhas vagas')
      expect(page).not_to have_link('Cadastrar nova vaga')
      expect(page). to have_link('Voltar')
    end

    scenario 'successfully with job listed' do
      headhunter = Headhunter.create!(email: 'test@test.com', password: '123456')
      Job.create!(title: 'Programador RoR',
                  level: 'Júnior',
                  number_of_vacancies: 4,
                  salary: 3500,
                  description: 'Programador Ruby on Rails',
                  abilities: 'CRUD, Git, Ruby, Ruby on Rails',
                  deadline: '20/01/2020',
                  start_date: '02/01/2020',
                  location: 'Remoto',
                  contract_type: 'CLT',
                  headhunter: headhunter)

      visit root_path
      click_on 'Vagas'

      expect(page).to have_content('Programador RoR')
      expect(page).to have_content('Júnior')
      expect(page).to have_content('4 vagas')
      expect(page).to have_content('CLT')
      expect(page).to have_link('Ver detalhes')

    end

    scenario 'and must be logged in to view job details' do
      headhunter = Headhunter.create!(email: 'test@test.com', password: '123456')
      Job.create!(title: 'Programador RoR',
                  level: 'Júnior',
                  number_of_vacancies: 4,
                  salary: 3500,
                  description: 'Programador Ruby on Rails',
                  abilities: 'CRUD, Git, Ruby, Ruby on Rails',
                  deadline: '20/01/2020',
                  start_date: '02/01/2020',
                  location: 'Remoto',
                  contract_type: 'CLT',
                  headhunter: headhunter)

      visit root_path
      click_on 'Vagas'
      click_on 'Ver detalhes'

      expect(page).to have_content('Você deve estar logado para acessar essa área!')
    end

    scenario 'and cannot go do direct job path' do
      headhunter = Headhunter.create!(email: 'test@test.com', password: '123456')
      job = Job.create!(title: 'Programador RoR',
                        level: 'Júnior',
                        number_of_vacancies: 4,
                        salary: 3500,
                        description: 'Programador Ruby on Rails',
                        abilities: 'CRUD, Git, Ruby, Ruby on Rails',
                        deadline: '20/01/2020',
                        start_date: '02/01/2020',
                        location: 'Remoto',
                        contract_type: 'CLT',
                        headhunter: headhunter)

      visit job_path(job)

      expect(page).to have_content('Você deve estar logado para acessar essa área!')
    end

    scenario 'and can return to home page' do
      visit root_path
      click_on 'Vagas'
      click_on 'Voltar'

      expect(current_path).to eq root_path
    end
  end

  context 'as Headhunter/CodeHunter' do
    scenario 'successfully without any jobs listed' do
      headhunter = Headhunter.create!(email: 'test@test.com', password: '123456')

      login_as headhunter, scope: :headhunter
      visit root_path
      click_on 'Vagas'

      expect(page).to have_content('Não há vagas cadastradas! Que tal ser o primeiro? Basta clicar aqui! :)')
      expect(page).to have_link('clicar aqui')
      expect(page).to have_link('Minhas Vagas')
      expect(page).to have_link('Nova Vaga')
      expect(page).to have_link('Voltar')
    end

    scenario 'successfully with jobs listed' do
      headhunter = Headhunter.create!(email: 'test@test.com', password: '123456')
      Job.create!(title: 'Programador RoR',
                  level: 'Júnior',
                  number_of_vacancies: 4,
                  salary: 3500,
                  description: 'Programador Ruby on Rails',
                  abilities: 'CRUD, Git, Ruby, Ruby on Rails',
                  deadline: '20/01/2020',
                  start_date: '02/01/2020',
                  location: 'Remoto',
                  contract_type: 'CLT',
                  headhunter: headhunter)

      login_as headhunter, scope: :headhunter
      visit root_path
      click_on 'Vagas'

      expect(page).to have_content('Programador RoR - 4 vagas')
      expect(page).to have_content('Júnior')
      expect(page).to have_content('4 vagas')
      expect(page).to have_content('CLT')
      expect(page).to have_link('Ver detalhes')

      expect(page).to have_link('Minhas Vagas')
      expect(page).to have_link('Nova Vaga')
      expect(page).to have_link('Sair')
      expect(page).not_to have_content('Não há vagas cadastradas! Que tal ser o primeiro? :)')
      expect(page).not_to have_link('Clique aqui')
      expect(page).to have_link('Voltar')
    end

    scenario 'and view job details' do
      headhunter = Headhunter.create!(email: 'test@test.com', password: '123456')
      Job.create!(title: 'Programador RoR',
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

      login_as headhunter, scope: :headhunter
      visit root_path
      click_on 'Vagas'
      click_on 'Ver detalhes'

      expect(page).to have_content('Nível')
      expect(page).to have_content('Faixa salarial')
      expect(page).to have_content('Descrição da vaga')
      expect(page).to have_content('Habilidades desejadas')
      expect(page).to have_content('Prazo de inscrição')
      expect(page).to have_content('Região de atuação')
      expect(page).to have_content('Tipo de contrato')
      expect(page).to have_content('Número de vagas')


      expect(page).to have_css('h1', text: 'Programador RoR')
      expect(page).to have_content('Júnior')
      expect(page).to have_content('R$ 3.500,00')
      expect(page).to have_content('Programador Ruby on Rails para atuar em startup')
      expect(page).to have_content('CRUD, Git, Ruby, Ruby on Rails, Boa comunicação')
      expect(page).to have_content('02/01/2020')
      expect(page).to have_content('20/01/2020')
      expect(page).to have_content('Remoto')
      expect(page).to have_content('CLT')
      expect(page).to have_link('Voltar')
    end
  end

  context 'as Candidate/Coder' do
    scenario 'and view no jobs listed' do
      candidate = Candidate.create!(name: 'Gustavo', last_name: 'Carvalho', email: 'test@test.com', password:'123456')

      login_as candidate, scope: :candidate
      visit root_path
      click_on 'Vagas'

      expect(current_path).to eq jobs_path
      expect(page).to have_content('Que pena! Não há vagas públicas listadas no momento.')

      expect(page).not_to have_content('Não há vagas públicas cadastradas! Que tal ser o primeiro? :)')
      expect(page).not_to have_link('clicar aqui')
      expect(page).not_to have_link('Minhas vagas')
      expect(page).not_to have_link('Cadastrar nova vaga')
      expect(page). to have_link('Voltar')
    end
    scenario 'and view jobs listed' do
      headhunter = Headhunter.create!(email: 'test@test.com', password: '123456')
      candidate = Candidate.create!(name: 'Gustavo', last_name: 'Carvalho', email: 'test@test.com', password:'123456')
      Job.create!(title: 'Programador RoR',
                  level: 'Júnior',
                  number_of_vacancies: 4,
                  salary: 3500,
                  description: 'Programador Ruby on Rails',
                  abilities: 'CRUD, Git, Ruby, Ruby on Rails',
                  deadline: '20/01/2020',
                  start_date: '02/01/2020',
                  location: 'Remoto',
                  contract_type: 'CLT',
                  headhunter: headhunter)

      login_as candidate, scope: :candidate
      visit root_path
      click_on 'Vagas'

      expect(page).to have_content('Programador RoR - 4 vagas')
      expect(page).to have_content('Júnior')
      expect(page).to have_content('4 vagas')
      expect(page).to have_content('CLT')
      expect(page).to have_link('Ver detalhes')
    end

    scenario 'and view job details' do
      candidate = Candidate.create!(name: 'Gustavo', last_name: 'Carvalho', email: 'test@test.com', password:'123456')
      headhunter = Headhunter.create!(email: 'test@test.com', password: '123456')
      Job.create!(title: 'Programador RoR',
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

      login_as candidate, scope: :candidate
      visit root_path
      click_on 'Vagas'
      click_on 'Ver detalhes'

      expect(page).to have_css('h1', text: 'Programador RoR')
      expect(page).to have_content('Júnior')
      expect(page).to have_content('R$ 3.500,00')
      expect(page).to have_content('Programador Ruby on Rails para atuar em startup')
      expect(page).to have_content('CRUD, Git, Ruby, Ruby on Rails, Boa comunicação')
      expect(page).to have_content('02/01/2020')
      expect(page).to have_content('20/01/2020')
      expect(page).to have_content('Remoto')
      expect(page).to have_content('CLT')
      expect(page).to have_link('Voltar')
      expect(page).to have_link('Aplicar para vaga')
    end
    scenario 'and if job is closed candidate cannot see it listed in jobs' do
      headhunter = Headhunter.create!(email: "test@test.com", password: "123456")
      Job.create!(title: "Programador RoR",
                  level: "Júnior",
                  number_of_vacancies: 1,
                  salary: 3500,
                  description: "Programador Ruby on Rails para atuar em startup",
                  abilities: "CRUD, Git, Ruby, Ruby on Rails, Boa comunicação",
                  deadline: "20/01/2020",
                  start_date: "02/01/2020",
                  location: "Remoto",
                  contract_type: "CLT",
                  headhunter: headhunter,
                  status: 1)

      candidate = Candidate.create!(email: "candidate@test.com", password: "123456")

      Profile.create!(candidate: candidate, name: "Gustavo", last_name: "Carvalho",
                      social_name: "Gustavo", birthday: "20/01/1994", about_yourself: "25 anos, eng civil",
                      university: "UFU", graduation_course: "Eng Civil", year_of_graduation: "20/08/2017",
                      company: "Geometa", role: "Estagiario", start_date: "20/01/2016", end_date: "20/06/2016",
                      experience_description: "Auxiliou na obra")

      login_as candidate, scope: :candidate
      visit root_path
      click_on 'Vagas'

      expect(page).not_to have_content('Programador RoR')
      expect(page).to have_content('Que pena! Não há vagas públicas listadas no momento.')
    end
    scenario 'and candidate cannot apply to closed job' do
      headhunter = Headhunter.create!(email: "test@test.com", password: "123456")
      job = Job.create!(title: "Programador RoR",
                        level: "Júnior",
                        number_of_vacancies: 1,
                        salary: 3500,
                        description: "Programador Ruby on Rails para atuar em startup",
                        abilities: "CRUD, Git, Ruby, Ruby on Rails, Boa comunicação",
                        deadline: "20/01/2020",
                        start_date: "02/01/2020",
                        location: "Remoto",
                        contract_type: "CLT",
                        headhunter: headhunter,
                        status: 1)

      candidate = Candidate.create!(email: "candidate@test.com", password: "123456")

      Profile.create!(candidate: candidate, name: "Gustavo", last_name: "Carvalho",
                      social_name: "Gustavo", birthday: "20/01/1994", about_yourself: "25 anos, eng civil",
                      university: "UFU", graduation_course: "Eng Civil", year_of_graduation: "20/08/2017",
                      company: "Geometa", role: "Estagiario", start_date: "20/01/2016", end_date: "20/06/2016",
                      experience_description: "Auxiliou na obra")

      login_as candidate, scope: :candidate
      visit new_job_application_path(job)

      expect(page).to have_content('Inscrições para essa vaga foram encerradas!')
    end
  end
end