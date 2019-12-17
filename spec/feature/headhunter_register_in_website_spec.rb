require 'rails_helper'

feature 'Headhunter register' do
  scenario 'sucessfully' do
    visit root_path
    click_on 'Sou um CodeHunter!'

    fill_in 'E-mail', with: 'test@test.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirme sua senha', with: '123456'
    click_on 'Sign up'

    expect(page).to have_content('Bem vindo! Você realizou seu registro com sucesso.')
    expect(page).to have_content('Sair')
  end
  scenario 'and cannot register if email already in database' do
    Headhunter.create!(email: 'test@test.com', password: '123456')

    visit root_path
    click_on 'Sou um CodeHunter!'

    fill_in 'E-mail', with: 'test@test.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirme sua senha', with: '123456'
    click_on 'Sign up'

    expect(page).to have_content('E-mail já está em uso')
  end
end