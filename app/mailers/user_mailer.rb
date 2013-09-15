class UserMailer < ActionMailer::Base
  default from: 'notifications@fbl-predictions.com'

  def prediction_made(mail_to, predictor, ordered_users)
    @ordered_users = ordered_users
    @predictor_email = predictor.email
    emails = []
    mail_to.each do |user|
      emails << user.email
    end
    mail(to: emails, subject: "Prediction made by #{@predictor_email}")
  end

  def results_updated(mail_to, standings)
    @standings = standings
    emails = []
    mail_to.each do |user|
      emails << user.email
    end
    mail(to: emails, subject: "Results have been updated")
  end
end