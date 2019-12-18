require 'rails_helper'

feature 'Headhunter/Codehunter register new job application' do
  scenario 'successfully' do
    headhunter = Headhunter.create!(email: 'test@test.com', password: '123456')

    login_as headhunter, scope: :headhunter
    visit root_path
    click_on 'Nova Vaga'

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

    expect(page).to have_content('Vaga criada com sucesso!')
    expect(page).to have_css('h1', text: 'Programador RoR')
    expect(page).to have_content('Júnior')
    expect(page).to have_content('R$ 3.500,00')
    expect(page).to have_content('Programador Ruby on Rails para atuar em startup')
    expect(page).to have_content('CRUD, Git, Ruby, Ruby on Rails, Boa comunicação')
    expect(page).to have_content('20/01/2020')
    expect(page).to have_content('Remoto')
    expect(page).to have_content('4')
    expect(page).to have_content('CLT')

    expect(page).to have_link('Nova Vaga')
    expect(page).to have_link('Editar Vaga')
    expect(page).to have_link('Excluir Vaga')
    expect(page).to have_link('Voltar')
  end
  scenario 'and must log in to register new job' do
    visit new_job_path

    expect(page).to have_content('Você deve ser um CodeHunter para acessar essa área!')
  end

  scenario 'and must fill in all fields' do
    headhunter = Headhunter.create!(email: 'test@test.com', password: '123456')

    login_as headhunter, scope: :headhunter
    visit root_path
    click_on 'Nova Vaga'
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir')
    expect(page).to have_content('não pode ficar em branco')
  end
end