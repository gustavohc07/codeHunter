require 'rails_helper'

feature 'User uses navbar' do
  context 'as non registered user' do
    scenario 'and view all links from navbar' do
      visit root_path

      expect(page).to have_link('Home')
      expect(page).to have_link('Sobre nós')
      expect(page).to have_link('Vagas')
      expect(page).to have_link('Sou um coder!')
      expect(page).to have_link('Sou um CodeHunter!')
      expect(page).to have_link('Login')
    end

    scenario 'and can go to jobs page' do
      visit root_path

      click_on 'Vagas'
      expect(current_path).to eq jobs_path
    end

    xscenario 'and can go to about us page' do
      visit root_path

      click_on 'Sobre nós'
      expect(current_path).to eq jobs_path
    end

    scenario 'and can go to coder registration page' do
      visit root_path

      click_on 'Sou um coder!'
      expect(current_path).to eq new_candidate_registration_path
    end
    scenario 'and can go to CodeHunter/Headhunter page' do
      visit root_path

      click_on 'Sou um CodeHunter!'

      expect(current_path).to eq new_headhunter_registration_path
    end

    xscenario 'and can go to login page regardless of being candidate or headhunter' do
      click_on 'Login'

      expect(current_path).to eq banana_path
    end

    scenario 'and can return to home page' do
      visit root_path

      click_on 'Vagas'
      click_on 'Home'

      expect(current_path).to eq root_path
    end
  end

  context 'as headhunter' do
    scenario 'and view all links from navbar' do
      headhunter = Headhunter.create!(email:'test@test.com', password: '1123456')

      login_as headhunter, scope: :headhunter
      visit root_path

      expect(page).to have_link('Home')
      expect(page).to have_link('Sobre nós')
      expect(page).to have_link('Vagas')
      expect(page).to have_link('Nova Vaga')
      expect(page).to have_link('Minhas Vaga')
      expect(page).to have_link('Sair')
    end

    scenario 'and can go to new job page' do
      headhunter = Headhunter.create!(email:'test@test.com', password: '1123456')

      login_as headhunter, scope: :headhunter
      visit root_path
      click_on 'Nova Vaga'

      expect(current_path).to eq new_job_path
    end

    scenario 'and can go to jobs page' do
      headhunter = Headhunter.create!(email:'test@test.com', password: '1123456')

      login_as headhunter, scope: :headhunter
      visit root_path
      click_on 'Vagas'

      expect(current_path).to eq jobs_path
    end

    xscenario 'and can go to about us page' do
      headhunter = Headhunter.create!(email:'test@test.com', password: '1123456')

      login_as headhunter, scope: :headhunter
      visit root_path
      click_on 'Sobre'

      expect(current_path).to eq banana_path
    end

    scenario 'and can go to my listed jobs page' do
      headhunter = Headhunter.create!(email:'test@test.com', password: '1123456')

      login_as headhunter, scope: :headhunter
      visit root_path
      click_on 'Minhas Vagas'

      expect(current_path).to eq job_myjobs_path(headhunter)
    end
  end

  context 'as candidate' do
    scenario 'and view all links from navbar' do
      candidate = Candidate.create!(name: 'Gustavo', last_name: 'Carvalho', email: 'test@test.com', password:'123456')

      login_as candidate, scope: :candidate
      visit root_path
      expect(page).to have_link('Home')
      expect(page).to have_link('Sobre nós')
      expect(page).to have_link('Vagas')
      expect(page).to have_link('Minhas Candidaturas')
      expect(page).to have_link('Criar Perfil')
      expect(page).to have_link('Sair')
    end
    xscenario 'and can go to about us page' do
      candidate = Candidate.create!(name: 'Gustavo', last_name: 'Carvalho', email: 'test@test.com', password:'123456')

      login_as candidate, scope: :candidate
      visit root_path
      click_on 'Sobre nós'

      expect(current_path).to eq banana_path
    end
    scenario 'and can go to jobs page' do
      candidate = Candidate.create!(name: 'Gustavo', last_name: 'Carvalho', email: 'test@test.com', password:'123456')

      login_as candidate, scope: :candidate
      visit root_path
      click_on 'Vagas'

      expect(current_path).to eq jobs_path
    end

    scenario 'and can see their job applications' do
      candidate = Candidate.create!(name: 'Gustavo', last_name: 'Carvalho', email: 'test@test.com', password:'123456')

      login_as candidate, scope: :candidate
      visit root_path
      click_on 'Minhas Candidaturas'

      expect(current_path).to eq applications_path
    end

    scenario 'and can see their profile' do
      candidate = Candidate.create!(name: 'Gustavo', last_name: 'Carvalho', email: 'test@test.com', password:'123456')
      Profile.create!(candidate: candidate)

      login_as candidate, scope: :candidate
      visit root_path
      click_on 'Meu Perfil'

      expect(current_path).to eq profile_path(candidate)
    end

    scenario 'and can go back to home page' do
      candidate = Candidate.create!(name: 'Gustavo', last_name: 'Carvalho', email: 'test@test.com', password:'123456')

      login_as candidate, scope: :candidate
      visit root_path
      click_on 'Vagas'
      click_on 'Home'

      expect(current_path).to eq root_path
    end
  end
end