class WorksController < ApplicationController
  def index
    @works = Work.all
    
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def work_params
    params.require(:work).permit(:shop_name, :employment_status_id, :work_name, :work_text, :phone).merge(admin_id: current_admin.id)
  end
end
