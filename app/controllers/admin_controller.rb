class AdminController < ApplicationController
  before_action :authenticate_admin!

  def index
    @clients = Client.all.order(id: :desc)
  end

  def pdf
    client = Client.find(params[:id].to_i)
    send_data client.document.download, filename: client.document.filename.to_s, content_type: client.document.content_type
  end

  def mail_pdf
    client = Client.find(params[:id].to_i)

    lob = Lob::Client.new(api_key: ENV['LOB_API_KEY'])
    response = lob.letters.create(
      description: "An Alaska Benefits application",
      to: {
        name: client.office_address[:name],
        address_line1: client.office_address[:address_line1],
        address_line2: client.office_address[:address_line2],
        address_city: client.office_address[:address_city],
        address_state: client.office_address[:address_state],
        address_zip: client.office_address[:address_zip]
      },
      from: {
        company: "Code for America",
        address_line1: "972 Mission St",
        address_city: "San Francisco",
        address_state: "CA",
        address_zip: "94103"
      },
      file: application_temp_url(client),
      color: true,
      address_placement: "insert_blank_page",
      extra_service: "certified",
      double_sided: false
    )

    puts response

    client.update mailed: true
    redirect_to "/admin"
  end

  private

  def application_temp_url(client)
    ActiveStorage::Current.host = request.base_url
    client.document.service_url
  end
end
