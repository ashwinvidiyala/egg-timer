class EggsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def timer
    if valid_slack_token?
      send_message_to_slack 'Time up!', 'ephemeral', params[:response_url]
      return render json: {
        response_type: 'ephemeral',
        text: "Timer has been set for #{params[:text]} minutes"
      }, status: 200
    else
      return render json: {}, status: 403
    end
  end

  private

  def valid_slack_token?
    params[:token] == Rails.application.credentials.slack_api_token
  end

  def send_message_to_slack timer = 0, message, response_type, url_input
    response = HTTP.post(url_input, json: {
      response_type: response_type,
      text: message
      })
    puts response
  end
end
