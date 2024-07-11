class RedactController < ApplicationController  
  protect_from_forgery with: :null_session

  def index 
    render json: "Redaction Service", status: :ok 
  end

  def modify
    statement = params["_json"]        
    log_data(statement)
    updated_statement = replace_words(statement)
    log_data('updated', updated_statement)    
    render json: updated_statement
  end

  private

  def replace_words(statement)
    # Generate regex to match the words in the statement irrespective of the case
    regex = Regexp.new("\\b(?:#{REDACTION_WORDS.join('|')})\\b", Regexp::IGNORECASE)
    # Replace the matched REDACTION_WORDS with the word 'REDACTED'
    statement.gsub(regex, "REDACTED")
  end

  def log_data(stmt_type='original', statement)
    CUSTOM_LOGGER.info("#{ stmt_type == 'original' ? 'Original' : 'Updated' } statement : #{statement}")
  end
end
