# class Link
class Link < Post

  def initialize
    super

    @url = ''
  end

  # Read user data from console
  def read_from_console
    puts "Please write URL: "
    @url = STDIN.gets.strip

    puts "Please write URL description"
    @text = STDIN.gets.strip
  end

  # parent method overriding for creating strings array
  def to_strings
    time_string = "Created: #{@created_at.strftime("%Y.%m.%d, %H:%M:%S")} \n\r \n\r"

    return [@url, @text, time_string]
  end
end