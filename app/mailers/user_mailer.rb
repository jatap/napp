class UserMailer < ActionMailer::Base
  default from: "julio.antunez.tarin@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.signin_notification.subject
  #
  def signup_notification(user)
    @user = user

    mail to: Figaro.env.admin_mail,
      subject: t("signup.notification.subject", user: user.fullname)
  end
end
