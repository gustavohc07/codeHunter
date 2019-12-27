require "rails_helper"

feature "Headhunter send job proposal to candidate" do
  scenario "successfully" do
    headhunter = Headhunter.create!(email: 'test@test.com', password: '123456')
    job = Job.create!(title: 'Programador RoR',
                      level: 'Júnior',
                      number_of_vacancies: 4,
                      salary: 3500,
                      description: 'Programador Ruby on Rails para atuar em startup',
                      abilities: 'CRUD, Git, Ruby, Ruby on Rails, Boa comunicação',
                      deadline: '20/01/2020',
                      start_date: '02/01/2020',
                      location: 'Remoto',
                      contract_type: 'CLT',
                      headhunter: headhunter)

    candidate = Candidate.create!(email: 'candidate@test.com', password: '123456')

    Profile.create!(candidate: candidate, name: 'Gustavo', last_name: 'Carvalho',
                    social_name: 'Gustavo', birthday: '20/01/1994', about_yourself: '25 anos, eng civil',
                    university: 'UFU', graduation_course: 'Eng Civil', year_of_graduation: '20/08/2017',
                    company: 'Geometa', role: 'Estagiario', start_date: '20/01/2016', end_date: '20/06/2016',
                    experience_description: 'Auxiliou na obra')

    Application.create!(job: job, candidate: candidate, message: 'Ja me candidatei')

    login_as headhunter, scope: :headhunter

    visit root_path
    click_on 'Minhas Vagas'
    click_on 'Programador RoR'
    click_on 'Ver Perfil'
    click_on 'Enviar Proposta'

    fill_in 'Início', with: '20/01/2020'
    fill_in 'Salário', with: '4000'
    fill_in 'Benefícios', with: 'VR, VA, Saúde'
    fill_in 'Bônus', with: 'PLR e bônus de desempenho'
    fill_in 'Outras Informações', with: 'Expediente mais curto toda sexta feira'
    click_on 'Enviar'

    expect(page).to have_content('Proposta para Gustavo Carvalho')
    expect(page).to have_content('Início')
    expect(page).to have_content('20/01/2020')
    expect(page).to have_content('Salário')
    expect(page).to have_content('R$ 4.000,00')
    expect(page).to have_content('Benefícios')
    expect(page).to have_content('VR, VA, Saúde')
    expect(page).to have_content('Bônus')
    expect(page).to have_content('PLR e bônus de desempenho')
    expect(page).to have_content('Outras Informações')
    expect(page).to have_content('Expediente mais curto toda sexta feira')
    expect(page).to have_link('Voltar')
  end

  context "and candidate accept proposal" do
  end

  context "and candidate refuse proposal" do
  end
end