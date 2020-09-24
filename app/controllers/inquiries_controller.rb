class InquiriesController < ApplicationController
  def new
    @inquiry = Inquiry.new
  end

  def create
    @inquiry = Inquiry.new(inquiry_params) 
    if @inquiry.save
      InquiryMailer.send_mail(@inquiry).deliver
      redirect_to root_path
    else
      render :new
    end
end

private
  def inquiry_params
    params.require(:inquiry).permit(:name, :mail, :message)
  end
end
