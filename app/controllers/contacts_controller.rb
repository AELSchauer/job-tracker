class ContactsController < ApplicationController

  def new
    @company = Company.find(params[:company_id])
    @contact = @company.contacts.new
  end

  def create
    @company = Company.find(params[:company_id])
    @contact = @company.contacts.new(contact_params)

    if @contact.save
      flash[:'success-message'] = "#{@contact.full_name} at #{@company.name} was successfully created!"
      redirect_to company_path(@company)
    else
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :position, :email)
  end
end
