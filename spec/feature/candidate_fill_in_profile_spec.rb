require 'rails_helper'

feature 'User as candidate can register his/her profile' do
  scenario 'successfully' do
    candidate = Candidate.create!(name: 'Gustavo', last_name: 'Carvalho', email: 'test@test.com', password: '123456')

    login_as candidate, scope: :candidate
    visit root_path
    click_on 'Criar Perfil'

    expect(current_path).to eq new_profile_path
    within 'Informações Pessoais' do
      #attach_file 'Imagem'
      expect(page).to have_content(candidate.name)
      expect(page).to have_content(candidate.last_name)
      fill_in 'Nome Social', with: ''
      fill_in 'Data de nascimento', with: '20/01/1994'
      fill_in 'Nos conte mais sobre você!', with: '25 anos, engenheiro civil migrando para programação.'
    end
    within 'Formação' do
      fill_in 'Universidade', with: 'Universidade Federal de Uberlândia'
      fill_in 'Curso', with: 'Engenharia Civil'
      fill_in 'Ano de Graduação', with: 2017
    end
    within 'Experiência Profissional' do
      fill_in 'Empresa', with: 'Geometa'
      fill_in 'Cargo', with: 'Estagiário'
      fill_in 'Data de Início', with: '01/01/2015'
      fill_in 'Data de Saída', with: '01/12/2015'
      fill_in 'Nos conte mais sobre essa experiência', with: 'Auxiliou em obras.'
    end
    click_on 'Atualizar Perfil'
  end
end