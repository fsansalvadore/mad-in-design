class ContactsController < ApplicationController
  skip_before_action :verify_authenticity_token
  require 'sendgrid-ruby'
  include SendGrid

  def index
    @contact = Contact.new
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    # from = Email.new(email: 'f.sansalvadore@gmail.com')
    # to = @contact.email
    # subject = 'Sending with SendGrid is Fun'
    # content = Content.new(type: 'text/plain', value: @contact.message)
    # mail = Mail.new(from, subject, to, content)

    # sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    # response = sg.client.mail._('send').post(request_body: mail.to_json)

    @contact.request = request
    if @contact.deliver
      flash[:success] = 'Messaggio inviato con successo'
      flash.now[:error] = nil
      redirect_to contacts_path
    else
      flash.now[:error] = 'Impossibile inviare il messaggio al momento.'
      render :index
    end

    #   respond_to do |format|
    #     @contact = Contact.new
    #     format.html { render 'index'}
    #     format.js   { flash.now[:success] = @message = "Grazie per il messaggio! Cercheremo di rispondere in breve tempo." }
    #   end
    # else
    #   respond_to do |format|
    #     format.html { render 'index' }
    #     format.js   { flash.now[:error] = @message = "Non è possibile inviare il messaggio al momento." }
    #   end
    # end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :telephone, :message, :nickname)
  end
end
