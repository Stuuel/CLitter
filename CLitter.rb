require 'jumpstart_auth'
require 'rainbow/ext/string'

class MicroBlogger
  attr_reader :client

  def initialize
    puts "Initializing CLitter"
    @client = JumpstartAuth.twitter
    puts "\e[H\e[2J"
  end

  def tweet(message)
    if message.length > 140
      puts "Warning, your message is too long".color(:red)
    else
      @client.update(message)
    end
  end

  def dm(target, message)
    screen_names = @client.followers.collect{ |follower|@client.user(follower).screen_name}
    if screen_names.include?(target)
      puts "Sending #{target} this direct message:".color(:yellow)
      puts message.color(:yellow)
      message = "d @#{target} #{message}"
      tweet(message)
    else
      puts "You can send direct messages only to people who follow you".color(:red)
    end
  end

  def followers_list
    screen_names = []
    users = @client.followers

    users.each do |follower|
      screen_names << @client.user(follower).screen_name
    end
    return screen_names
  end

  def marketing_to_followers(message)
    followers_list.each do |screen_name|
      dm(screen_name, message)
    end
  end

  def run
    puts "Welcome to the CLitter Twitter Client".color(:cyan)
    command = ""
    while command != "q"
      printf "enter command: ".color(:green)
      parts = gets.chomp.split(" ")
      command = parts[0]
      case command
        when 'q' then puts "Goodbye!"
        when 't' then tweet(parts[1..-1].join(" "))
        when 'dm' then dm(parts[1], parts[2..-1].join(" "))
        when 'marketing' then puts marketing_to_followers(parts[1..-1].join(" "))
        else
          puts "Sorry, I don't know how to #{command} and now i am sad.".color(:red)
      end
    end
  end

  blogger = MicroBlogger.new
  blogger.run
end
