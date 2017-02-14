class UserMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
 include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
 default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views

  def confirmation_instructions(record, token, opts={})
    @token = token
    require 'mailgun'
    mg_client = Mailgun::Client.new "key-a2ba6d81aa1687b45c6ea03b82221013"

   html = render_to_string template: "devise/mailer/confirmation_instructions.html.erb"
    # Define your message parameters
    message_params = {:from    => 'Articity <thisisarticity@gmail.com>',
                      :to      => record.email,
                      :subject => 'Welcome to Articity!',
                      :html    => html.to_str}

    # Send your message through the client
    mg_client.send_message "mail.articity.in", message_params
  end

  def reset_password_instructions(record, token, opts={})
    # code to be added here later
  end
end