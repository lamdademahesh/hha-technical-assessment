class RedactController < ApplicationController  
  protect_from_forgery with: :null_session

  def index 
    render json: "Redaction Service", status: :ok 
  end

  def modify
    statement = params["_json"]
    regex = Regexp.new("\\b(?:#{REDACTION_WORDS.join('|')})\\b", Regexp::IGNORECASE)
    CUSTOM_LOGGER.info("Original statement : #{statement}")
    updated_statement = statement.gsub(regex, "REDACTED")
    CUSTOM_LOGGER.info("Original statement : #{updated_statement}")
    # Replace the matched REDACTION_WORDS with the word 'REDACTED'
    render json: updated_statement
  end
end
