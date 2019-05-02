class ClientsController < ApplicationController
  # GET /clients/1
  def show
    @client = Client.find params[:id]

    redirect_to root_path unless current_client == @client
    @feedback = Feedback.new
  end

  # GET /clients/new
  def new
    @client = Client.new
  end

  def index
    redirect_to "/upload"
  end

  # POST /clients
  def create
    @client = Client.new(client_params)

    if @client.save
      session[:current_client_id] = @client.id
      redirect_to @client, notice: 'Client was successfully created.'
    else
      render :new
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def client_params
    params.require(:client).permit(:phone, :text_opt_in, :email, :email_opt_in, :office_choice, :document)
  end
end
