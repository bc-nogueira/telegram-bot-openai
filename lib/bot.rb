require_relative 'openai_service'
require_relative '../constants'

require 'awesome_print'
require 'pry'
require 'telegram/bot'

class Bot
  TELEGRAM_TOKEN = ENV['TELEGRAM_TOKEN'] || Constants::TELEGRAM_TOKEN
  HELP_TEXT = "This is a bot connected with Chat GPT 3.5. Each functionality is separated into different modes. The available commands are:\n"\
              "/mode  - Shows which mode you're in.\n"\
              "/chat - Change to chat mode.\n"\
              "/image - Change to image mode."

  def initialize
    @openai_service = OpenAIService.new
    @mode = 'chat'
  end

  def run
    Telegram::Bot::Client.run(TELEGRAM_TOKEN) do |bot|
      bot.listen do |user_message|
        content = process_user_message(user_message)
        print_message(content, bot, user_message)
      end
    end
  end

  private

  def process_user_message(user_message)
    case user_message.text
    when '/chat'
      change_to_chat_mode
    when '/image'
      change_to_image_mode
    when '/mode'
      { type: 'text', text: "You are in #{@mode} mode." }
    when '/help'
      { type: 'text', text: HELP_TEXT }
    else
      interact_with_openai(user_message)
    end
  end

  def change_to_chat_mode
    @mode = 'chat'
    { type: 'text', text: 'Changing to chat mode.' }
  end

  def change_to_image_mode
    @mode = 'image'
    { type: 'text', text: 'Changing to image mode.' }
  end

  def interact_with_openai(user_message)
    return @openai_service.chat(user_message.text) if @mode == 'chat'

    return @openai_service.generate_image(user_message.text) if @mode == 'image'

    { type: 'text', text: 'Command not recognized.' }
  end

  def print_message(content, bot, user_message)
    if content[:type] == 'text'
      bot.api.send_message(chat_id: user_message.chat.id, text: content[:text])
    elsif content[:type] == 'image_url'
      bot.api.send_photo(chat_id: user_message.chat.id, caption: "Requested image: #{user_message.text}", photo: content[:text])
    end
  end
end
