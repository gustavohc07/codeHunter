require 'rails_helper'

feature 'User register as candidate' do
  scenario 'successfully go to new candidate path' do
    visit root_path
    click_on 'Sou um coder!'

    expect(current_path).to eq new_candidate_registration_path
  end
  scenario 'succesfully register' do
    visit root_path
    click_on 'Sou um coder!'

    fill_in 'Nome', with: 'Gustavo'
    fill_in 'Sobrenome', with: 'Carvalho'
    fill_in 'E-mail', with: 'candidate@test.com'
    fill_in 'Senha', with: 'candidate@test.com'
    fill_in 'Confirme sua senha', with: 'candidate@test.com'
    click_on 'Sign up'
  end
  scenario 'and must nome register with same email' do
    Candidate.create!(name: 'Gustavo', last_name: 'Carvalho', email: 'test@test.com', password: '123456')

    visit root_path
    click_on 'Sou um coder!'

    fill_in 'Nome', with: 'Gustavo'
    fill_in 'Sobrenome', with: 'Carvalho'
    fill_in 'E-mail', with: 'test@test.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirme sua senha', with: '1234556'
    click_on 'Sign up'

    expect(page).to have_content('E-mail já está em uso')
  end
end