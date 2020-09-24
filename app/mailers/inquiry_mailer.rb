class InquiryMailer < ApplicationMailer
  def send_mail(inquiry)
    @inquiry = inquiry
    mail(
      to:   'e.mc2.1012md@gmail.com',
      subject: 'お問い合わせ通知'
    )
   end
end
