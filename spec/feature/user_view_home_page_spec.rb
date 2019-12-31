require 'rails_helper'


feature 'user view home page' do
  context 'non registered' do
    scenario 'successfully' do
      visit root_path

      expect(page).to have_css('h1', text: 'CodeHunters')
      expect(page).to have_link('Sou um coder!')
      expect(page).to have_link('Sou um CodeHunter!')
      expect(page).to have_content('Vagas')
    end
  end
  context 'as a headhunter' do
    scenario 'sucessfully' do
      headhunter = Headhunter.create!(email: 'test@test.com', password: '123456')

      login_as(headhunter, scope: :headhunter)
      visit root_path
      expect(page).to have_css('h1', text: 'CodeHunters')
      expect(page).not_to have_link('Sou um coder!')
      expect(page).not_to have_link('Sou um CodeHunter!')
      expect(page).to have_content('Nova Vaga')
    end

    scenario 'and logout' do
        headhunter = Headhunter.create!(email: 'test@test.com', password: '123456')

        login_as(headhunter, scope: :headhunter)
        visit root_path
        click_on 'Sair'

        expect(page).to have_content('Logout efetuado com sucesso.')
    end
  end
  context 'as a candidate/coder' do
    scenario 'successfully' do
      candidate = Candidate.create!(email:'candidate@test.com', password: '123456')

      login_as candidate, scope: :candidate
      visit root_path
      expect(page).to have_css('h1', text: 'CodeHunters')
      expect(page).not_to have_link('Sou um coder!')
      expect(page).not_to have_link('Sou um CodeHunter!')
      expect(page).to have_content('Minhas Candidaturas')
    end

    scenario 'and logout' do
      candidate = Candidate.create!(email:'candidate@test.com', password: '123456')

      login_as candidate, scope: :candidate
      visit root_path
      click_on 'Sair'

      expect(page).to have_content('Logout efetuado com sucesso.')
    end
  end
end