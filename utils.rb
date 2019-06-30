require "mail"
require "erb"

MAIL_CONFIG = YAML.load(File.read("build/mail.yaml"))

module Utils
  def erb(template, vars)
    ERB.new(template).result(OpenStruct.new(vars).instance_eval { binding })
  end

  def send_mail(data)
    Mail.defaults { delivery_method :smtp, MAIL_CONFIG["smtp_config"] }
    mail = Mail.new do
      from MAIL_CONFIG["smtp_config"][:user_name]
      to MAIL_CONFIG["receiver"][:to]
      cc MAIL_CONFIG["receiver"][:cc]
      subject MAIL_CONFIG["mail"][:subject]

      html_part do
        content_type "text/html; charset=UTF-8"
        body erb(File.read(MAIL_CONFIG["mail"][:template]), data)
      end
    end
    mail.deliver!
  end
end
