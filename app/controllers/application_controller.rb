class ApplicationController < ActionController::Base
  def current_client
    Client.find(session[:current_client_id])
  end
end
