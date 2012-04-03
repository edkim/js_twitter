require 'jumpstart_auth'

class JSTwitter
  attr_reader :client

  def initialize
    puts "Initializing"
    @client = JumpstartAuth.twitter
  end

  def tweet(message)
    if message.length <= 140
      @client.update(message) 
    else 
   	  puts "Error: message too long"
    end
  end

  def dm(target, message)
    puts "Trying to send #{target} this direct message:"
    puts message
    tweet("d "+ target + " " + message)
  end

  def everyones_last_tweet
    friends = @client.friends
    friends.each do |friend|
      tweet_date = friend.status.created_at.strftime("%A, %b %d")
      puts friend.screen_name + " said this on " + tweet_date + "..."
      puts friend.status.text
      puts ""  # Just print a blank line to separate people
    end
  end

  def shorten(original_url)
    # Shortening Code
    puts "Shortening this URL: #{original_url}"
  end

  def run
    command = ""
  	while command != "q"
      puts ""
      printf "enter command: "
      input = gets.chomp
      parts = input.split(" ")
      command = parts[0]
      case command
        when 'q' then puts "Goodbye!"
        when 't' then tweet(parts[1..-1].join(" "))
        when 'dm' then dm(parts[1], parts[2..-1].join(" "))
        when 'elt' then everyones_last_tweet
        when 's' then shorten(parts[1])
        else puts "Sorry, I don't know how to #{command}"
      end     
  	end
  end

  jst = JSTwitter.new
  jst.run
end

