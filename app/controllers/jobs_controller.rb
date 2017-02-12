class JobsController < ApplicationController
  def index
    @company = Company.find(params[:company_id])
    @jobs = @company.jobs.order(:title)
  end

  def new
    @company = Company.find(params[:company_id])
    @job = Job.new()
    @categories = Category.drop_down_list
  end

  def create
    @company = Company.find(params[:company_id])
    @job = @company.jobs.new(job_params)
    if @job.save
      flash[:'success-message'] = "#{@job.title} at #{@company.name} was successfully created!"
      redirect_to job_path(@job)
    else
      @categories = Category.drop_down_list
      render :new
    end
  end

  def show
    @job = Job.find(params[:id])
    @company = @job.company
    @comments = @job.comments.order(created_at: :desc)
  end

  def edit
    @job = Job.find(params[:id])
    @company = @job.company
    @categories = Category.drop_down_list
  end

  def update
    @job = Job.find(params[:id])
    @company = Company.find(params[:company_id])

    if @job.update(job_params)
      flash[:'success-message'] = "#{@job.title} at #{@company.name} was successfully updated!"
      redirect_to job_path(@job)
    else
      @categories = Category.drop_down_list
      render :edit
    end
  end

  def destroy
    job = Job.find(params[:id])
    company = Company.find(params[:company_id])
    job.destroy

    flash[:'success-message'] = "#{job.title} at #{company.name} was successfully deleted!"

    redirect_to company_path(company)
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :level_of_interest, :city, :category_id)
  end
end
