class ClientsController < ApplicationController
  def index
    redirect_to "/upload"
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)

    if @client.save
      session[:current_client_id] = @client.id
      redirect_to @client
    else
      render :new
    end
  end

  def update
    authenticate_admin!

    @client = Client.find params[:id]
    @client.update client_params

    redirect_to "/admin"
  end

  def show
    @client = Client.find params[:id]

    redirect_to root_path unless current_client == @client
    @feedback = Feedback.new
  end

  private

  # Only allow a trusted parameter "white list" through.
  def client_params
    params.require(:client).permit(:phone, :text_opt_in, :email, :email_opt_in, :office_choice, :document, :name, :street_address, :city, :state, :zip_code)
  end
end
