class ClientsController < ApplicationController
  # GET /clients/1
  def show
    @client = Client.find params[:id]
    @feedback = Feedback.new
  end

  # GET /clients/new
  def new
    @client = Client.new
  end

  # POST /clients
  def create
    @client = Client.new(client_params)

    if @client.save
      redirect_to @client, notice: 'Client was successfully created.'
    else
      render :new
    end
  end

  def pdf
    client = Client.find(params[:client_id].to_i)
    send_data client.document.download, filename: client.document.filename.to_s, content_type: client.document.content_type
  end

  private

  # Only allow a trusted parameter "white list" through.
  def client_params
    params.require(:client).permit(:phone, :text_opt_in, :email, :email_opt_in, :office_choice, :document)
  end
end
