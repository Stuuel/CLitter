require 'jumpstart_auth'

class MicroBlogger
  attr_reader :client

  def initialize
    puts "Initializing CLitter"
    @client = JumpstartAuth.twitter
  end
  def tweet(message)
    if message.length > 140
      puts "Warning, your message is to long"
    else
      @client.update(message)
    end
  end
  def run
    puts "Welcome to the CLitter Twitter Client"
    command = ""
    while command != "q"
      printf "enter command: "
      input = gets.chomp
      parts = input.split(" ")
      command = parts[0]
      case command
        when 'q' then puts "Goodbye!"
        when 't' then tweet(parts[1..-1].join(" "))
        else
          puts "Sorry, I don't know how to #{command} and now i am sad."
      end
    end
  end
  blogger = MicroBlogger.new
  #blogger.tweet("First test on my Ruby Application, testing now if i get an error yay. So since i didn't got an error because of the length i will give it another")
  blogger.run
end
