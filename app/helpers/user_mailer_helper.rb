module UserMailerHelper
  def user_mailer(record, action, opts={})

    html = render_to_string template: "devise/mailer/#{action.to_s}"
    document = Roadie::Document.new html
    document = document.transform

    @mail_letter.sender = {
      "name": "Planet of Vitamins",
      "email": "planet.vitamins.63@example.com"
    }
    @mail_letter.to = [{ "email": @to_email }]
    @mail_letter.html_content = document
    @mail_letter.text_content = document
    @mail_letter.subject = @subject
    @mail_letter.reply_to = {
      "email": "planet.vitamins.63@example.com",
      "name": "Planet of Vitamins"
    }

    begin
      # Send a transactional email
      result = @send_email.send_transac_email(@mail_letter)

      # logger.debug "#{'=' * 110 }"
      # logger.debug "Result: \n#{result}"
      # logger.debug "#{'=' * 110 }"

      return result

    rescue SibApiV3Sdk::ApiError => e
      puts "Exception when calling TransactionalEmailsApi->send_transac_email: #{e}"
    end
  end
end
