# class Memo
class Memo < Post
  # read user data from console
  def read_from_console
    puts "Please write your note. After complete please type \"end\" to finish."
    @text = []
    user_input = nil

    while user_input != "end" do
      user_input = STDIN.gets.chomp
      @text << user_input
    end

    @text.pop
  end

  # add additional info to instance after info was read from db
  def load_data(data_hash)
    super
    @text = data_hash['text'].split('\n')
  end

  # add one key for which will be written in db
  def to_db_hash
    super.merge(
      {
        'text' => @text.join("\n\r"),
      }
    )
  end

  # parent method overriding for creating strings array
  def to_strings
    time_string = "Created: #{@created_at.strftime("%Y.%m.%d, %H:%M:%S")} \n\r \n\r"

    return @text.unshift(time_string)
  end
end
