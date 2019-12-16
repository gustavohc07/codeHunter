require 'rails_helper'

feature 'Headhunter/Codehunter register new job application' do
  scenario 'successfully' do
    headhunter = Headhunter.create!(email: 'test@test.com', password: '123456')

    login_as headhunter, scope: :headhunter
    visit root_path
    click_on 'Cadastrar nova vaga'

    fill_in 'Título da vaga', with: 'Programador RoR'
    fill_in 'Nível', with: 'Júnior'
    fill_in 'Número de Vagas', with: 4
    fill_in 'Faixa Salarial', with: 3500
    fill_in 'Descrição', with: 'Programador Ruby on Rails para atuar em startup'
    fill_in 'Habilidades Desejadas', with: 'CRUD, Git, Ruby, Ruby on Rails, Boa comunicação'
    fill_in 'Data limite para inscrição', with: '20/01/2020'
    fill_in 'Data inicial do processo', with: '02/01/2020'
    fill_in 'Região de atuação', with: 'Remoto'
    fill_in 'Tipo de contrato', with: 'CLT'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Programador RoR - 4 vagas')
    expect(page).to have_content('Júnior')
    expect(page).to have_content('R$ 3500,00')
    expect(page).to have_content('Programador Ruby on Rails para atuar em startup')
    expect(page).to have_content('CRUD, Git, Ruby, Ruby on Rails, Boa comunicação')
    expect(page).to have_content('20/01/2020')
    expect(page).to have_content('Remoto')

    expect(page).to have_link('Nova vaga')
    expect(page).to have_link('Editar vaga')
    expect(page).to have_link('Excluir vaga')
    expect(page).to have_link('Voltar')
  end
  scenario 'and must log in to register new job' do
    visit new_job_path

    expect(page).to have_content('Voce nao tem autorização')
  end

  scenario 'and must fill in all fields' do
    headhunter = Headhunter.create!(email: 'test@test.com', password: '123456')

    login_as headhunter, scope: :headhunter
    visit root_path
    click_on 'Registrar nova vaga'
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros:')
    expect(page).to have_content('não deve ficar em branco!')
  end
end