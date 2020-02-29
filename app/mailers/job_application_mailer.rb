class JobApplicationMailer < ApplicationMailer
  default from: 'job-application@codehunter.com'

  def application_email(application_id)
    @application = Application.find(application_id)
    mail(to: @application.candidate.email,
         subject: "Caro #{@application.candidate.profile.name}"\
             ', sua inscrição foi realizada com sucesso')
  end

  def cancelation_email(application_id)
    @application = Application.find(application_id)
    mail(to: @application.candidate.email,
         subject: "Inscrição para #{@application.job.title} " \
                  'cancelada.')
  end
end
