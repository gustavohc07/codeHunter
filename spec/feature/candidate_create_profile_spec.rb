require 'rails_helper'

feature 'User as candidate can register his/her profile' do
  scenario 'successfully' do
    candidate = Candidate.create!(email: 'test@test.com', password: '123456')

    login_as candidate, scope: :candidate
    visit root_path
    click_on 'Criar Perfil'

    expect(page).to have_css('h2', text: 'Informações Pessoais')
    attach_file 'Imagem', Rails.root.join('spec', 'support', 'image.png')
    fill_in 'Nome', with: 'Gustavo'
    fill_in 'Sobrenome', with: 'Carvalho'
    fill_in 'Nome Social', with: 'Gustavo'
    fill_in 'Data de Nascimento', with: '20/01/1994'
    fill_in 'Nos conte mais sobre você!', with: '25 anos, engenheiro civil migrando para programação.'

    expect(page).to have_css('h2', text: 'Formação')
    fill_in 'Universidade', with: 'Universidade Federal de Uberlândia'
    fill_in 'Curso', with: 'Engenharia Civil'
    fill_in 'Ano de Graduação', with: '20/08/2017'

    expect(page).to have_css('h2', text: 'Experiência Profissional')
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

    expect(page).to have_link('Editar meu perfil')
    expect(page).to have_link('Ir para vagas!')
  end

  xscenario 'and successfully with name from candidate' do
    candidate = Candidate.create!(name: 'Gustavo', last_name: 'Carvalho', email: 'test@test.com', password: '123456')

    login_as candidate, scope: :candidate
    visit root_path
    click_on 'Criar Perfil'

    expect(page).to have_css('h2', text: 'Informações Pessoais')
    attach_file 'Imagem', Rails.root.join('spec', 'support', 'image.png')
    fill_in 'Nome Social', with: 'Teste'
    fill_in 'Data de Nascimento', with: '20/01/1994'
    fill_in 'Nos conte mais sobre você!', with: '25 anos, engenheiro civil migrando para programação.'

    expect(page).to have_css('h2', text: 'Formação')
    fill_in 'Universidade', with: 'Universidade Federal de Uberlândia'
    fill_in 'Curso', with: 'Engenharia Civil'
    fill_in 'Ano de Graduação', with: '20/08/2017'

    expect(page).to have_css('h2', text: 'Experiência Profissional')
    fill_in 'Empresa', with: 'Geometa'
    fill_in 'Cargo', with: 'Estagiário'
    fill_in 'Data de Início', with: '01/01/2015'
    fill_in 'Data de Saída', with: '01/12/2015'
    fill_in 'Nos conte mais sobre essa experiência', with: 'Auxiliou em obras.'
    click_on 'Enviar'


    expect(page).to have_xpath('//img')
    expect(page).to have_content('Informações Pessoais')
    expect(page).to have_content('Nome')
    expect(page).to have_content('Gustavo')
    expect(page).to have_content('Sobrenome')
    expect(page).to have_content('Carvalho')
    expect(page).to have_content('Nome Social')
    expect(page).to have_content('Teste')
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

    expect(page).to have_link('Editar meu perfil')
    expect(page).to have_link('Ir para vagas!')
  end
  scenario 'and can create a profile without filling any information' do
    candidate = Candidate.create!(name: 'Gustavo', last_name: 'Carvalho', email: 'test@test.com', password: '123456')

    login_as candidate, scope: :candidate
    visit root_path
    click_on 'Criar Perfil'
    click_on 'Enviar'

    expect(current_path).to eq profile_path(candidate)
    expect(page).to have_content('Meu Perfil')
  end

  scenario 'and got to edit page if try to create another profile' do
    candidate = Candidate.create!(name: 'Gustavo', last_name: 'Carvalho', email: 'test@test.com', password: '123456')
    Profile.create!(candidate: candidate)

    login_as candidate, scope: :candidate
    visit new_profile_path

    expect(current_path).to eq edit_profile_path(candidate)
  end
end