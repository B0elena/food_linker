# Preview all emails at http://localhost:3000/rails/mailers/inquiry_mailer
class InquiryMailerPreview < ActionMailer::Preview
  def inquiry
    inquiry = Inquiry.new(name: "侍 太郎", message: "問い合わせメッセージ")
   
    InquiryMailer.send_mail(inquiry)
  end
end
