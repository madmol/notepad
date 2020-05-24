class Post
  def initialize
    @text = nil
    @created_at = Time.now
  end

  def read_from_console

  end

  def to_strings

  end

  def file_path
    current_path = File.dirname(__FILE__)
    file_name = @created_at.strftime("#{self.class.name}_%Y_%m_%d_%H_%M_%S.txt")
    return current_path + "/" + file_name
  end

  def save
    file = File.new(file_path, "w:UTF-8")
    for item in strings do
      file.puts(item)
    end

    file.close
  end

end