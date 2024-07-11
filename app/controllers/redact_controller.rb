class RedactController < ApplicationController
  def index 
    render json: "Redaction Service", status: :ok 
  end
end
