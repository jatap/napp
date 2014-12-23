# User mailer Class.
#
# @author julio.antunez.tarin@gmail.com
class UserMailer < ActionMailer::Base

  # Set default from
  default from: "julio.antunez.tarin@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.signin_notification.subject
  #
  # @param [User] user the user.
  def signup_notification(user)
    @user = user

    mail to: Figaro.env.admin_mail,
      subject: t("signup.notification.subject", user: user.fullname)
  end

end
