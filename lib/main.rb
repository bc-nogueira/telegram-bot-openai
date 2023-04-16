require_relative 'bot'

require 'awesome_print'
require 'pry'

puts 'Starting server'
Process.setproctitle('telegram-gpt')
Bot.new.run
