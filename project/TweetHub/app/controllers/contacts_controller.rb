class ContactsController < ApplicationController
	def index
    		@contact = Contact.new
  	end

	def create
	    @contact= Contact.new(contact_params)
	    redirect_to :controller => 'static_pages', :action => 'index'
	end
	private

  	def contact_params
    		params[:contact].permit(:name, :email, :feedback)
  	end
end
