require 'rails_helper'

feature 'Candidate apply to a listed job' do
  context 'and profile is not complete' do
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
    end
  end

  context 'and profile is complete' do
    scenario 'and apply to job successfully' do

    end
  end
end