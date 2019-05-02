class AdminController < ApplicationController
  before_action :authenticate_admin!

  def index
    @clients = Client.all.order(id: :desc)
  end

  def pdf
    client = Client.find(params[:id].to_i)
    send_data client.document.download, filename: client.document.filename.to_s, content_type: client.document.content_type
  end
end
