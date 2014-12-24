class Emailer < ActionMailer::Base
  default from: APP_CONFIG['gmail_username']

  def send_email(email,name)
    @name = name
    mail(to: email, subject: 'Sample Email')
  end

  def send_email_change_password(user)
    @user = user
    mail(to: @user.email, subject: 'Confirm password')
  end

end
