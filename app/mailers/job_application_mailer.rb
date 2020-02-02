# frozen_string_literal: true

class JobApplicationMailer < ApplicationMailer
  default from: 'job-application@codehunter.com'

  def application_email(application_id)
    @application = Application.find(application_id)
    mail(to: @application.candidate.email, subject: "Caro #{@application.candidate.profile.name}, sua inscricao foi realizada com sucesso")
  end
end
