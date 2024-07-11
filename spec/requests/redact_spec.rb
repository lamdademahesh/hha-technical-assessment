require 'rails_helper'

RSpec.describe "Redact", type: :request do 
  describe 'POST #redact' do 
    it "returns updated statement" do       
      post "/redact", params: { "_json" => "A dog, a monkey or a dolphin are all mammals. A snake, however, is not a mammal, it is a reptile. Who can say what a DogSnake is?" }      
      expect(response.body).to eq("A REDACTED, a monkey or a REDACTED are all mammals. A REDACTED, however, is not a REDACTED, it is a reptile. Who can say what a DogSnake is?")
    end
  end

  describe 'GET #redact' do
    it "returns Redaction Service" do 
      get "/redact"    
      expect(response.body).to eq("Redaction Service")
    end
  end

  describe "POST #redaction" do 
    it "returns 404 status code" do
      post "/redaction", params: { "_json" => "A dog, a monkey or a dolphin are all mammals. A snake, however, is not a mammal, it is a reptile. Who can say what a DogSnake is?" }
      expect(response.status).to eq(404)
    end
  end
end