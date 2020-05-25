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

    puts "What's the due dete? Please insert date in DD.MM.YYYY format, for example 25.05.2020"
    user_input = STDIN.gets.strip
    @due_date = Date.parse(user_input)
  end

  # parent method overriding for creating strings array
  def to_strings
    time_string = "Created: #{@created_at.strftime("%Y.%m.%d, %H:%M:%S")} \n\r \n\r"

    deadline = "Due date: #{@due_date}"

    return [deadline, @text, time_string]
  end
end