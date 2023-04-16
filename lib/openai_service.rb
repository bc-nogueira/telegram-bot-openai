require_relative '../constants'

require 'awesome_print'
require 'openai'
require 'pry'

class OpenAIService
  OPENAI_SECRET_KEY = ENV['OPENAI_SECRET_KEY'] || Constants::OPENAI_SECRET_KEY

  def initialize
    @openai_client = OpenAI::Client.new(access_token: OPENAI_SECRET_KEY)
    @messages = []
  end

  def chat(message)
    @messages.push({ role: 'user', content: message })

    response = @openai_client.chat(
      parameters: {
        model: 'gpt-3.5-turbo', # Required.
        # model: 'gpt-4', # Required.
        messages: @messages,
        temperature: 0.7,
      }
    )

    return { type: 'text', text: response.dig('error', 'message') }  unless response.dig('error', 'message').nil?

    response_text = response.dig('choices', 0, 'message', 'content')
    @messages.push({ role: 'assistant', content: response_text })
    { type: 'text', text: response_text }
  end

  def generate_image(description)
    response = @openai_client.images.generate(parameters: { prompt: description })

    if response.dig('error', 'message').nil?
      { type: 'image_url', text: response.dig('data', 0, 'url') }
    else
      { type: 'text', text: response.dig('error', 'message') }
    end
  end
end
