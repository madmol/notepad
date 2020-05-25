# class Post
class Post
  #singleton method for choose
  def self.post_types
    [Memo, Link, Task]
  end

  #singleton method for create object os chosen type
  def self.create(type_index)
    return post_types[type_index].new
  end

  def initialize
    @text = nil
    @created_at = Time.now
  end

  # abstract method for child class for reading data from console
  def read_from_console
  #  to do
  end

  # abstract method for child class for creating strings array
  def to_strings
  #  to do
  end

  # notepad created file path
  def file_path
    current_path = File.dirname(__FILE__)
    file_name = @created_at.strftime("#{self.class.name}_%Y_%m_%d_%H_%M_%S.txt")
    return current_path + "/" + file_name
  end

  # save data fo file
  def save
    file = File.new(file_path, "w:UTF-8")
    for item in to_strings do
      file.puts(item)
    end

    file.close
  end
end