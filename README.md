# Telegram Bot with OpenAI

This is a Telegram bot integrated with OpenAI. Currently it allows interaction with Chat GPT 3.5 and image generation.

This app doesn't save any information to the database.

## Gems

The main gems are:

- [telegram-bot-ruby](https://github.com/atipugin/telegram-bot-ruby)
- [ruby-openai](https://github.com/alexrudall/ruby-openai)

## How to run locally

Before you run this project you need to:

- Create your Telegram bot.
  - You can create your bot by following this Telegram tutorial: [Creating a new bot](https://core.telegram.org/bots/features#creating-a-new-bot).
- Create your OpenAI account [here](https://auth0.openai.com/u/signup/identifier?state=hKFo2SBVNzIza29xR1NBR2FpNDcxTkVZbW5pZjZzQkdXdzhkU6Fur3VuaXZlcnNhbC1sb2dpbqN0aWTZIFRPdENCNWloUUg2OU1FLWdTTUdueFJyLU1KbjVicVFUo2NpZNkgRFJpdnNubTJNdTQyVDNLT3BxZHR3QjNOWXZpSFl6d0Q).
  - Get your API key [here](https://beta.openai.com/account/api-keys).

Then you need to:

1. Clone this repo.
2. Install dependencies: `bundle install`
3. Set tokens:
    - In the `constants.rb` file:
      - Set `TELEGRAM_TOKEN` to your Telegram bot token.
      - Set `OPENAI_SECRET_KEY` to your OpenAI secret key.
4. Execute it with: `ruby lib/main.rb`

## How to interact with the bot

This chatbot has the following commands:

- **/mode**: Shows which mode you're in.
- **/chat**: Change to chat mode.
- **/image**: Change to image mode.
- **/help**: Show brief instructions and available commands.

The bot will initially be in the chat mode.

In the chat mode you can interact with Chat GPT but you can't ask it to generate images.
To do that you need to change to image mode (`/image`) and then ask to generate an image.

The bot keeps conversation context to allow Chat GPT refer to prior messages.
But this is limited to OpenAI [Token](https://platform.openai.com/docs/introduction/tokens) count and long conversations might generate errors.

This bot follows OpenAI restriction while you interact with it.

## License

The project is available as open source under the terms of the [MIT License](https://opensource.org/license/mit/).