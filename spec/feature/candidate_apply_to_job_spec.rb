require 'rails_helper'

feature 'Candidate apply to a listed job' do
  context 'and profile is not complete or non existent' do
    scenario 'and go back to edit profile to complete it' do
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
      Profile.create!(candidate: candidate)

      login_as candidate, scope: :candidate
      visit jobs_path
      click_on 'Ver detalhes'
      click_on 'Aplicar para vaga'

      expect(current_path).to eq edit_profile_path(candidate.profile)
      expect(page).to have_content('Preencha seu perfil para aplicar à vaga!')
    end

    scenario 'and go to register profile page' do
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

      login_as candidate, scope: :candidate
      visit jobs_path
      click_on 'Ver detalhes'
      click_on 'Aplicar para vaga'

      expect(current_path).to eq new_profile_path
      expect(page).to have_content('Vocẽ deve possuir um perfil para aplicar à vaga')
    end
  end

  context 'and profile is complete' do
    scenario 'is at job application' do
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

      login_as candidate, scope: :candidate
      visit root_path
      click_on 'Vagas'
      click_on 'Ver detalhes'
      click_on 'Aplicar para vaga'

      expect(current_path).to eq new_application_path
    end
    scenario 'and successfully apply for the job' do
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

      login_as candidate, scope: :candidate
      visit root_path
      click_on 'Vagas'
      click_on 'Ver detalhes'
      click_on 'Aplicar para vaga'

      fill_in 'Diga ao CodeHunter o por que voce e ideal para a vaga! :)', with: 'Pq eu sou um teste.'
      click_on 'Candidatar!'

      expect(page).to have_content(job.title)
      expect(page).to have_content('Mensagem ao CodeHunter:')
      expect(page).to have_content('Pq eu sou um teste.')
      expect(page).to have_link('Editar mensagem')

    end
  end
end