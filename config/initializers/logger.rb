custom_logger = ActiveSupport::Logger.new(Rails.root.join('log', 'redact.log'))
custom_logger.formatter = proc do |severity, datetime, progname, msg|
  formatted_datetime = datetime.strftime("%Y-%m-%d %H:%M:%S")
  "[#{formatted_datetime}] #{severity}: #{msg}\n"
end

CUSTOM_LOGGER = custom_logger
