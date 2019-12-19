require 'rails_helper'

feature 'Candidate edit profile' do
  scenario 'successfully' do
    candidate = Candidate.create!(email: 'test@test.com', password: '123456')
    profile = Profile.create!(social_name: 'Test', birthday: '20/01/1994',
                              university: 'UFU',
                              company: 'Test', candidate: candidate)

    login_as candidate, scope: :candidate
    visit profile_path(profile)
    click_on 'Editar meu perfil'

    attach_file 'Imagem', Rails.root.join('spec', 'support', 'image.png')
    fill_in 'Nome', with: 'Gustavo'
    fill_in 'Sobrenome', with: 'Carvalho'
    fill_in 'Nome Social', with: 'Gustavo'
    fill_in 'Data de Nascimento', with: '20/01/1994'
    fill_in 'Nos conte mais sobre você!', with: '25 anos, engenheiro civil migrando para programação.'

    fill_in 'Universidade', with: 'Universidade Federal de Uberlândia'
    fill_in 'Curso', with: 'Engenharia Civil'
    fill_in 'Ano de Graduação', with: '20/08/2017'

    fill_in 'Empresa', with: 'Geometa'
    fill_in 'Cargo', with: 'Estagiário'
    fill_in 'Data de Início', with: '01/01/2015'
    fill_in 'Data de Saída', with: '01/12/2015'
    fill_in 'Nos conte mais sobre essa experiência', with: 'Auxiliou em obras.'
    click_on 'Enviar'

    expect(page).to have_content('Bem vindo ao seu perfil!')
    expect(page).to have_xpath('//img')
    expect(page).to have_content('Informações Pessoais')
    expect(page).to have_content('Nome')
    expect(page).to have_content('Gustavo')
    expect(page).to have_content('Sobrenome')
    expect(page).to have_content('Carvalho')
    expect(page).to have_content('Nome Social')
    expect(page).to have_content('Gustavo')
    expect(page).to have_content('Data de Nascimento')
    expect(page).to have_content('20/01/1994')
    expect(page).to have_content('Nos conte mais sobre você!')
    expect(page).to have_content('25 anos, engenheiro civil migrando para programação.')

    expect(page).to have_content('Formação')
    expect(page).to have_content('Universidade')
    expect(page).to have_content('Universidade Federal de Uberlândia')
    expect(page).to have_content('Curso')
    expect(page).to have_content('Engenharia Civil')
    expect(page).to have_content('Ano de Graduação')
    expect(page).to have_content('20/08/2017')

    expect(page).to have_content('Experiência Profissional')
    expect(page).to have_content('Empresa')
    expect(page).to have_content('Geometa')
    expect(page).to have_content('Cargo')
    expect(page).to have_content('Estagiário')
    expect(page).to have_content('Data de Início')
    expect(page).to have_content('01/01/2015')
    expect(page).to have_content('Data de Saída')
    expect(page).to have_content('01/12/2015')
    expect(page).to have_content('Nos conte mais sobre essa experiência')
    expect(page).to have_content('Auxiliou em obras.')
  end
  scenario 'and try to access another profile from edit path' do
    candidate = Candidate.create!(email: 'test@test.com', password: '123456')
    profile = Profile.create!(social_name: 'Test', birthday: '20/01/1994',
                              university: 'UFU',
                              company: 'Test', candidate: candidate)
    other_candidate = Candidate.create!(email:'test2@test.com', password: '123456')
    other_profile = Profile.create!(candidate: other_candidate)

    login_as candidate, scope: :candidate
    visit edit_profile_path(other_profile)

    expect(current_path).to eq profile_path(profile)
  end
end
