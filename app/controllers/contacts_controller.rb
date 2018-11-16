class ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :block_crossprofile_access
  before_action :recover_profile

  def index
    @contacts = @profile.contacts
  end

  def new; end

  def edit
    @contact = Contact.find(params[:id])
  end

  def create
    @contact = Contact.new(contact_params)

    @contact.profile = @profile

    if @contact.save
      flash[:success] = 'Contact registered sucessfully'
      redirect_to profile_contacts_path(profile_email: @profile.email)
    else
      render 'new'
    end
  end

  def update
    @contact = Contact.find(params[:id])

    if @contact.update(contact_params)
      flash[:success] = 'Contact updated sucessfully'
      redirect_to profile_contacts_path(profile_email: @contact.profile.email)
    else
      render 'edit'
    end
  end

  def destroy
    @contact = Contact.find(params[:id])

    profile_email = @contact.profile.email

    @contact.destroy

    redirect_to profile_contacts_path(profile_email: profile_email)
  end

  private

  def contact_params
    params.require(:contact).permit(:email, :name, :phone, :mobile)
  end
end
