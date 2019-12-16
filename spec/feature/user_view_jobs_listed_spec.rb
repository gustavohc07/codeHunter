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
      Job.create!(title: 'Programador RoR',
                  level: 'Júnior',
                  number_of_vacancies: 4,
                  salary: 3500,
                  description: 'Programador Ruby on Rails',
                  abilities: 'CRUD, Git, Ruby, Ruby on Rails',
                  deadline: 20/01/2020,
                  start_date: 02/01/2020,
                  location: 'Remoto',
                  contract_type: 'CLT')

      visit root_path
      click_on 'Vagas'

      expect(page).to have_content('Programador RoR')
      expect(page).to have_content('Júnior')
      expect(page).to have_content('4 vagas')
      expect(page).to have_content('CLT')
      expect(page).to have_link('Ver detalhes')

    end

    scenario 'and must be logged in to view job details' do
      Job.create!(title: 'Programador RoR',
                  level: 'Júnior',
                  number_of_vacancies: 4,
                  salary: 3500,
                  description: 'Programador Ruby on Rails',
                  abilities: 'CRUD, Git, Ruby, Ruby on Rails',
                  deadline: 20/01/2020,
                  start_date: 02/01/2020,
                  location: 'Remoto',
                  contract_type: 'CLT')

      visit root_path
      click_on 'Vagas'
      click_on 'Ver detalhes'

      expect(page).to have_content('Para continuar, faça login ou registre-se.')
    end

    scenario 'and cannot go do direct job path' do
      job = Job.create!(title: 'Programador RoR',
                  level: 'Júnior',
                  number_of_vacancies: 4,
                  salary: 3500,
                  description: 'Programador Ruby on Rails',
                  abilities: 'CRUD, Git, Ruby, Ruby on Rails',
                  deadline: 20/01/2020,
                  start_date: 02/01/2020,
                  location: 'Remoto',
                  contract_type: 'CLT')

      visit job_path(job)

      expect(page).to have_content('Para continuar, faça login ou registre-se.')
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
      expect(page).to have_link('Minhas vagas')
      expect(page).to have_link('Cadastrar nova vaga')
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
                  deadline: 20/01/2020,
                  start_date: 02/01/2020,
                  location: 'Remoto',
                  contract_type: 'CLT')

      login_as headhunter, scope: :headhunter
      visit root_path
      click_on 'Vagas'

      expect(page).to have_content('Programador RoR')
      expect(page).to have_content('Júnior')
      expect(page).to have_content('4 vagas')
      expect(page).to have_content('CLT')
      expect(page).to have_link('Ver detalhes')

      expect(page).to have_link('Minhas vagas')
      expect(page).to have_link('Cadastrar nova vaga')
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
                  contract_type: 'CLT')

      login_as headhunter, scope: :headhunter
      visit root_path
      click_on 'Vagas'
      click_on 'Ver detalhes'

      expect(page).to have_content('Nível')
      expect(page).to have_content('Faixa salarial')
      expect(page).to have_content('Descrição da vaga')
      expect(page).to have_content('Habilidades desejadas')
      expect(page).to have_content('Prazo de inscrição')


      expect(page).to have_css('h1', text: 'Programador RoR - 4 vagas')
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

  end
end