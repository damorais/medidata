class ContactsController < ApplicationController
   def new
   end
  
   def index
     @contacts = Contact.all
   end

   def create 
      @contact = Contact.new(contact_create_params)
      
	  if @contact.save
         flash[:success] = "O contato foi criado com sucesso!"
      end
	   
	  redirect_to action: :index
	  #render 'new'  
   end 

   def edit
     @contact = Contact.find(params[:id])
     #redirect_to action: :index
   end

   def update
     @contact = Contact.find(params[:id])

     if @contact.update(contact_update_params)
       flash[:success] = "O contato foi alterado com sucesso!"
     end

     redirect_to action: :index

   end
   
   def destroy
      @contact = Contact.find(params[:id])

      if @contact.destroy
         flash[:success] = "O contato foi excluído com sucesso!"
      end

      redirect_to action: :index
   end
   
   private
   def contact_create_params
      params.require(:contact).permit(:contactemail, 
                                      :contactname, 
                                      :contactphone, 
                                      :contactmobile)
   end
  
   private
   def contact_update_params
      params.require(:contact).permit(:contactemail, 
                                      :contactname, 
                                      :contactphone, 
                                      :contactmobile)
   end
  
end