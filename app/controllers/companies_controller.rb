class CompaniesController < ApplicationController
  def index
    @companies = Company.order(:name)
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)

    if @company.save
      flash[:'success-message'] = "#{@company.name} was successfully created!"
      redirect_to company_path(@company)
    else
      render :new
    end
  end

  def show
    @company  = Company.find(params[:id])
    @jobs     = @company.jobs.order(:title)
    @contacts = @company.contacts.order(:last_name)
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])

    if @company.update(company_params)
      flash[:'success-message'] = "#{@company.name} was successfully updated!"
      redirect_to company_path(@company)
    else
      render :edit
    end
  end

  def destroy
    company = Company.find(params[:id])
    company.destroy

    flash[:'success-message'] = "#{company.name} was successfully deleted!"
    redirect_to companies_path
  end

  private

  def company_params
    params.require(:company).permit(:name, :city)
  end
end
