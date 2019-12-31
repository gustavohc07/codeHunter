require 'rails_helper'

feature 'User register as candidate' do
  scenario 'successfully go to new candidate path' do
    visit root_path
    click_on 'Sou um coder!'
    click_on 'Sign up'

    expect(current_path).to eq new_candidate_registration_path
  end

  scenario 'succesfully register' do
    visit root_path
    click_on 'Sou um coder!'
    click_on 'Sign up'

    fill_in 'Nome', with: 'Gustavo'
    fill_in 'Sobrenome', with: 'Carvalho'
    fill_in 'E-mail', with: 'candidate@test.com'
    fill_in 'Senha', with: 'candidate@test.com'
    fill_in 'Confirme sua senha', with: 'candidate@test.com'
    click_on 'Sign up'

    expect(current_path).to eq new_profile_path
  end

  scenario 'and must not register with same email' do
    Candidate.create!(name: 'Gustavo', last_name: 'Carvalho', email: 'test@test.com', password: '123456')

    visit root_path
    click_on 'Sou um coder!'
    click_on 'Sign up'

    fill_in 'Nome', with: 'Gustavo'
    fill_in 'Sobrenome', with: 'Carvalho'
    fill_in 'E-mail', with: 'test@test.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirme sua senha', with: '123456'
    click_on 'Sign up'

    expect(page).to have_content('E-mail já está em uso')
  end
  scenario 'and go to new profile path if profile do not exist' do
    visit root_path
    click_on 'Sou um coder!'
    click_on 'Sign up'

    fill_in 'Nome', with: 'Gustavo'
    fill_in 'Sobrenome', with: 'Carvalho'
    fill_in 'E-mail', with: 'test@test.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirme sua senha', with: '123456'
    click_on 'Sign up'

    expect(current_path).to eq new_profile_path
  end

  scenario 'and go to edit profile path if profile is not complete' do
    candidate = Candidate.create!(email: 'test@test.com', password: '123456')
    profile = Profile.create!(social_name: 'Test', birthday: '20/01/1994',
                              university: 'UFU',
                              company: 'Test', candidate: candidate)

    visit root_path
    click_on 'Sou um coder!'

    fill_in 'E-mail', with: 'test@test.com'
    fill_in 'Senha', with: '123456'
    click_on 'Log in'

    expect(current_path).to eq edit_profile_path(profile)
  end

  scenario 'and go to root path if profile is complete' do
    candidate = Candidate.create!(email: 'test@test.com', password: '123456')
    Profile.create!(candidate: candidate, name: 'Gustavo', last_name: 'Carvalho',
                    social_name: 'Gustavo', birthday: '20/01/1994', about_yourself: '25 anos, eng civil',
                    university: 'UFU', graduation_course: 'Eng Civil', year_of_graduation: '20/08/2017',
                    company: 'Geometa', role: 'Estagiario', start_date: '20/01/2016', end_date: '20/06/2016',
                    experience_description: 'Auxiliou na obra')

    visit root_path
    click_on 'Sou um coder!'

    fill_in 'E-mail', with: 'test@test.com'
    fill_in 'Senha', with: '123456'
    click_on 'Log in'

    expect(current_path).to eq root_path
  end
end