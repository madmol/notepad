# class Post
require 'sqlite3'

class Post
  SQLITE_DB_FILE = 'notepad'

  # class method to create an object with chosen type
  def self.create(type)
    return post_types[type].new
  end

  # class method to find all posts in DB
  def self.find_all(limit, type)
    db = SQLite3::Database.open(SQLITE_DB_FILE)

    db.results_as_hash = false

    query = "SELECT rowid, * FROM posts "

    query += "WHERE type = :type " unless type.nil?
    query += "ORDER by rowid DESC "

    query += "LIMIT :limit " unless limit.nil?

    begin
      statement = db.prepare(query)
    rescue SQLite3::SQLException => e
      puts "Failed to execute the request to database #{SQLITE_DB_FILE}"
      abort e.message
    end

    statement.bind_param('type', type) unless type.nil?
    statement.bind_param('limit', limit) unless limit.nil?

    begin
      result = statement.execute!
    rescue SQLite3::SQLException => e
      puts "Failed to execute the request to database #{SQLITE_DB_FILE}"
      abort e.message
    end

    statement.close
    db.close

    result
  end

  # class method to find by id post in DB
  def self.find_by_id(id)
    return if id.nil?
    db = SQLite3::Database.open(SQLITE_DB_FILE)

    db.results_as_hash = true
    begin
      result = db.execute("SELECT * FROM posts WHERE rowid = ?", id)
    rescue SQLite3::SQLException => e
      puts "Failed to execute the request to database #{SQLITE_DB_FILE}"
      abort e.message
    end
    db.close

    return if result.empty?

    result = result[0]

    post = create(result['type'])
    post.load_data(result)
    post
  end

  #class method for choose post type
  def self.post_types
    {'Memo' => Memo, 'Task' => Task, 'Link' => Link}
  end

  def initialize
    @text = nil
    @created_at = Time.now
  end

  # notepad created file path
  def file_path
    current_path = File.dirname(__FILE__)
    file_name = @created_at.strftime("#{self.class.name}_%Y_%m_%d_%H_%M_%S.txt")
    return current_path + "/" + file_name
  end

  def load_data(data_hash)
    @created_at = Time.parse(data_hash['created_at'])
    @text = data_hash['text']
  end

  # abstract method for child class for reading data from console
  def read_from_console
    #  to do
  end

  # save data fo file
  def save
    file = File.new(file_path, "w:UTF-8")
    for item in to_strings do
      file.puts(item)
    end

    file.close
  end

  # save data fo db
  def save_to_db
    db = SQLite3::Database.open(SQLITE_DB_FILE)
    db.results_as_hash = true
    begin
      db.execute(
        "INSERT INTO posts (" +
          to_db_hash.keys.join(',') +
          ")" +
          " VALUES (" +
          ('?,' * to_db_hash.keys.size).chomp(',') +
          ")",
        to_db_hash.values
      )
    rescue SQLite3::SQLException => e
      puts "Failed to execute the request to database #{SQLITE_DB_FILE}"
      abort e.message
    end
    insert_row_id = db.last_insert_row_id

    db.close

    insert_row_id
  end

  # add keys which will be written in db
  def to_db_hash
    {
      'type' => self.class.name,
      'created_at' => @created_at.to_s
    }
  end

  # abstract method for child class for creating strings array
  def to_strings
    #  to do
  end
end
