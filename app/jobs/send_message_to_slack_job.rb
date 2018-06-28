class SendMessageToSlackJob < ApplicationJob
  queue_as :default

  def perform message, response_type, url_input
    response = HTTP.post(url_input, json: {
    response_type: response_type,
    text: message
    })
    puts response
  end
end
