# class Link
class Link < Post

  def initialize
    super

    @url = ''
  end

  # add additional info to instance after info was read from db
  def load_data(data_hash)
    super
    @url = data_hash['url']
  end


  # Read user data from console
  def read_from_console
    puts "Please write URL: "
    @url = STDIN.gets.strip

    puts "Please write URL description"
    @text = STDIN.gets.strip
  end

  # add two keys for which will be written in db
  def to_db_hash
    super.merge(
      {
        'text' => @text,
        'url' => @url
      }
    )
  end

  # parent method overriding for creating strings array
  def to_strings
    time_string = "Created: #{@created_at.strftime("%Y.%m.%d, %H:%M:%S")} \n\r \n\r"

    return [@url, @text, time_string]
  end
end

