# class Task
require 'date'

class Task < Post
  def initialize
    super

    @due_date = Time.now
  end

  # Read user data from console
  def read_from_console
    puts "What's need to do?"
    @text = STDIN.gets.strip

    puts "What's the due date? Please insert date in DD.MM.YYYY format, for example 25.05.2020"
    user_input = STDIN.gets.strip
    @due_date = Date.parse(user_input)
  end

  # add additional info to instance after info was read from db
  def load_data(data_hash)
    super
    @due_date = Date.parse(data_hash['due_date'])
  end

  # add two keys for which will be written in db
  def to_db_hash
    super.merge(
      {
        'text' => @text,
        'due_date' => @due_date.to_s
      }
    )
  end

  # parent method overriding for creating strings array
  def to_strings
    time_string = "Created: #{@created_at.strftime("%Y.%m.%d, %H:%M:%S")} \n\r \n\r"

    deadline = "Due date: #{@due_date}"

    return [deadline, @text, time_string]
  end
end
