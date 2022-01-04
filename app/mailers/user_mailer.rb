class UserMailer < Devise::Mailer
  # Responsible for sending letters with confirmation of the mailing address.

  include UserMailerHelper # gives access to UserMailerHelper helper

  helper :application
  layout 'mailer'
  before_action :init

  default template_path: 'devise/mailer'

  def init
    @send_email = SibApiV3Sdk::TransactionalEmailsApi.new # api instance
    @mail_letter = SibApiV3Sdk::SendSmtpEmail.new # SendSmtpEmail | Values to send a transactional email
  end

  def confirmation_instructions(record, token, opts={})
    @user = record
    @token = token
    @to_email = @user.email
    @subject = "Confirm Email"

    user_mailer(record, :confirmation_instructions, opts)
  end

  def reset_password_instructions(record, token, opts = {})
    @user = record
    @token = token
    @to_email = @user.email
    @subject = "Password reset"

    user_mailer(record, :reset_password_instructions, opts)
  end

  def unlock_instructions(record, token, opts = {})
    @user = record
    @token = token
    @to_email = @user.email
    @subject = "Unlock account"

    user_mailer(record, :unlock_instructions, opts)
  end

  def email_changed(record, opts = {})
    @user = record
    @to_email = @user.email
    @subject = "Email was changed"

    user_mailer(record, :email_changed, opts)
  end

  def password_change(record, opts = {})
    @user = record
    @to_email = @record.email
    @subject = "Password was changed"

    user_mailer(record, :password_change, opts)
  end
end
