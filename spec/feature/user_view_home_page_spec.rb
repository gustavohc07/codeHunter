require 'rails_helper'


feature 'user view home page' do
  context 'non registered' do
    scenario 'successfully' do
      visit root_path

      expect(page).to have_css('h1', text: 'CodeHunters')
      expect(page).to have_link('Sou um coder!')
      expect(page).to have_link('Sou um hunter!')
      expect(page).to have_content('Vagas')
      expect(page).to have_content('Entrar')
    end
  end
end