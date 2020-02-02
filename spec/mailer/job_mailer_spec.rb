require "rails_helper"

RSpec.describe JobApplicationMailer do
  describe "#application_email" do
    it "should send to candidate email" do
      headhunter = Headhunter.create!(email: "test@test.com", password: "123456")
      job = Job.create!(title: "Programador RoR",
                        level: "Júnior",
                        number_of_vacancies: 4,
                        salary: 3500,
                        description: "Programador Ruby on Rails para atuar em startup",
                        abilities: "CRUD, Git, Ruby, Ruby on Rails, Boa comunicação",
                        deadline: "20/01/2020",
                        start_date: "02/01/2020",
                        location: "Remoto",
                        contract_type: "CLT",
                        headhunter: headhunter)
      candidate = Candidate.create!(email: "candidate@test.com", password: "123456")
      other_candidate = Candidate.create!(email: "candidate2@test.com", password: "123456")
      Profile.create!(candidate: candidate, name: "Gustavo", last_name: "Carvalho",
                      social_name: "Gustavo", birthday: "20/01/1994", about_yourself: "25 anos, eng civil",
                      university: "UFU", graduation_course: "Eng Civil", year_of_graduation: "20/08/2017",
                      company: "Geometa", role: "Estagiario", start_date: "20/01/2016", end_date: "20/06/2016",
                      experience_description: "Auxiliou na obra")
      application = Application.create!(job: job, candidate: candidate, message: "Ja me candidatei")

      mail = JobApplicationMailer.application_email(application.id)

      expect(mail.to).to include(candidate.email)
      expect(mail.to).not_to include(other_candidate.email)
    end

    it "should come from a default email" do
      headhunter = Headhunter.create!(email: "test@test.com", password: "123456")
      job = Job.create!(title: "Programador RoR",
                        level: "Júnior",
                        number_of_vacancies: 4,
                        salary: 3500,
                        description: "Programador Ruby on Rails para atuar em startup",
                        abilities: "CRUD, Git, Ruby, Ruby on Rails, Boa comunicação",
                        deadline: "20/01/2020",
                        start_date: "02/01/2020",
                        location: "Remoto",
                        contract_type: "CLT",
                        headhunter: headhunter)
      candidate = Candidate.create!(email: "candidate@test.com", password: "123456")
      Profile.create!(candidate: candidate, name: "Gustavo", last_name: "Carvalho",
                      social_name: "Gustavo", birthday: "20/01/1994", about_yourself: "25 anos, eng civil",
                      university: "UFU", graduation_course: "Eng Civil", year_of_graduation: "20/08/2017",
                      company: "Geometa", role: "Estagiario", start_date: "20/01/2016", end_date: "20/06/2016",
                      experience_description: "Auxiliou na obra")
      application = Application.create!(job: job, candidate: candidate, message: "Ja me candidatei")

      mail = JobApplicationMailer.application_email(application.id)

      expect(mail.from).to include("job-application@codehunter.com")
    end

    it "should have some subject email" do
      headhunter = Headhunter.create!(email: "test@test.com", password: "123456")
      job = Job.create!(title: "Programador RoR",
                        level: "Júnior",
                        number_of_vacancies: 4,
                        salary: 3500,
                        description: "Programador Ruby on Rails para atuar em startup",
                        abilities: "CRUD, Git, Ruby, Ruby on Rails, Boa comunicação",
                        deadline: "20/01/2020",
                        start_date: "02/01/2020",
                        location: "Remoto",
                        contract_type: "CLT",
                        headhunter: headhunter)
      candidate = Candidate.create!(email: "candidate@test.com", password: "123456")
      Profile.create!(candidate: candidate, name: "Gustavo", last_name: "Carvalho",
                      social_name: "Gustavo", birthday: "20/01/1994", about_yourself: "25 anos, eng civil",
                      university: "UFU", graduation_course: "Eng Civil", year_of_graduation: "20/08/2017",
                      company: "Geometa", role: "Estagiario", start_date: "20/01/2016", end_date: "20/06/2016",
                      experience_description: "Auxiliou na obra")
      application = Application.create!(job: job, candidate: candidate, message: "Ja me candidatei")

      mail = JobApplicationMailer.application_email(application.id)

      expect(mail.subject).to include("Caro #{candidate.profile.name}, sua inscricao foi realizada com sucesso")
    end

    it "should have a body" do
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
      application = Application.create!(job: job, candidate: candidate, message: 'Ja me candidatei')

      mail = JobApplicationMailer.application_email(application.id)

      expect(mail.body).to include("Caro #{application.candidate.profile.name}, sua candidatura para #{application.job.title} foi realizada com sucesso!")
    end
  end
end