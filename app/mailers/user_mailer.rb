# Delivering the email
# 
# Once you have the settings right, sending the email is done by:
# 
#   Mail.deliver do
#     to 'yourname@example.org'
#     from 'hisname@example.net'
#     subject 'testing email'
#     body 'testing email'
#   end
#
# Or
#
# Mail.deliver do
#   to 'yourname@example.org'
#   from 'Example Name <hisname@example.net>'
#   subject 'First multipart email sent with Mail'
#
#   text_part do
#     body 'This is plain text'
#   end
#
#   html_part do
#     content_type 'text/html; charset=UTF-8'
#     body '<h1>This is HTML</h1>'
#   end
# end
# 
# Or by calling deliver on a Mail message
# 
#   mail = Mail.new do
#     to 'yourname@example.org'
#     from 'hisname@example.net'
#     subject 'testing email'
#     body 'testing email'
#   end
# 
#   mail.deliver!

# Call UserMailer.welcome to deliver welcome message
class UserMailer
  def self.welcome
    Mail.deliver do
      to 'yourname@example.org'
      from 'Example Name <hisname@example.net>'
      subject 'Welcome!'

      html_part do
        content_type 'text/html; charset=UTF-8'
        body '<h1>Hello World!</h1>'
      end
    end
  end
end

