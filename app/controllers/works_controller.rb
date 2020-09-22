class WorksController < ApplicationController
  def index
    @works = Work.all.order('created_at DESC')
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

  def destroy
    work = Work.find(params[:id])
    if work.destroy
      redirect_to works_path
    else
      render :index
    end
  end

  def edit
    @work = Work.find(params[:id])
  end

  def update
    @work = Work.find(params[:id])
    if @work.update(work_params)
      redirect_to works_path
    else
      render :edit
    end
  end

  private
  def work_params
    params.require(:work).permit(:shop_name, :employment_status_id, :work_name, :work_text, :phone).merge(admin_id: current_admin.id)
  end
end
