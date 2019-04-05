class PagesController < ApplicationController
  def complete
    envelope_id = params[:env]
    account_id = ENV["DOCUSIGN_ACCOUNT_ID"]
    auth_token = ENV["DOCUSIGN_AUTH_TOKEN"]
    
    recipients = HTTParty.get("https://demo.docusign.net/restapi/v2/accounts/#{account_id}/envelopes/#{envelope_id}/recipients", {
      headers: {"Authorization" => "Bearer #{auth_token}"}
    })

    raise "Set the DocuSign auth token" unless recipients.ok?

    signer = {}
    signer[:name] = recipients["signers"][0]["name"]
    signer[:email] = recipients["signers"][0]["email"]
    signer[:signed_at] = DateTime.parse(recipients["signers"][0]["signedDateTime"]).strftime("%c")

    pdf_contents = HTTParty.get("https://demo.docusign.net/restapi/v2/accounts/#{account_id}/envelopes/#{envelope_id}/documents/1", {
      headers: {"Authorization" => "Bearer #{auth_token}"}
    })

    File.write('public/docusigned.pdf', pdf_contents.force_encoding(Encoding::UTF_8))

    sleep 2

    lob_response = HTTParty.post("https://api.lob.com/v1/letters", {
      basic_auth: { username: ENV["LOB_API_KEY"], password: nil },
      body: { description: "Alaska Application for Benefits Demo Letter",
        to: {
          name: "Sharon Langevin",
          company: "Code for America",
          address_line1: "972 Mission St",
          address_city: "San Francisco",
          address_state: "CA",
          address_zip: "94103"
        },
        from: {
          company: "Code for America",
          address_line1: "972 Mission St",
          address_city: "San Francisco",
          address_state: "CA",
          address_zip: "94103"
        },
        file: "https://www.alaskabenefits.org/docusigned.pdf",
        color: true,
        address_placement: "insert_blank_page",
        extra_service: "certified",
        double_sided: false
      }
    })

    puts lob_response

    render :complete, locals: { signer: signer, lob_response: lob_response }
  end
end