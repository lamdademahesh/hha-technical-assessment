class RedactController < ApplicationController  
  def index 
    return render json: "Redaction Service", status: :ok if request.get?
    statement = params["_json"]  
    return render json: "Missing param", status: :unprocessable_entity unless statement.present?           
    render json: update_redaction_words(statement), status: :ok
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

  def update_redaction_words(statement)
    log_data(statement)
    updated_statement = replace_words(statement)
    log_data('updated', updated_statement)    
    updated_statement
  end
end
