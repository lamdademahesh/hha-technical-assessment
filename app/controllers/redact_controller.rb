class RedactController < ApplicationController  
  protect_from_forgery with: :null_session

  def index 
    render json: "Redaction Service", status: :ok 
  end

  def modify
    statement = params["_json"]
    regex = Regexp.new("\\b(?:#{REDACTION_WORDS.join('|')})\\b", Regexp::IGNORECASE)
    # Replace the matched REDACTION_WORDS with the word 'REDACTED'
    render json: statement.gsub(regex, "REDACTED")
  end
end
