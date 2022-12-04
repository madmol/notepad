require_relative 'lib/post'
require_relative 'lib/link'
require_relative 'lib/memo'
require_relative 'lib/task'
require 'optparse'

id_input = ARGV[1]
# id, limit, type
options = {}

# Options
OptionParser.new do |opt|
  # Text that will be printed every time script run with -h
  opt.banner = 'Usage: read.rb [options]'

  opt.on('--h', 'Prints this help') do
    puts opt
    exit
  end

  # Option --type
  opt.on('--type POST_TYPE', 'what type of posts do you want to show ' \
         '(default every type)') { |o| options[:type] = o }

  # Option --id show post id in db
  opt.on('--id POST_ID', 'if id set — show in full only chosen ' \
         'post') { |o| options[:id] = o }

  # Option --limit how many last posts do we want to see
  opt.on('--limit NUMBER', 'how many last posts to show ' \
         '(default all)') { |o| options[:limit] = o }
end.parse!

result =
  if options[:id]
    Post.find_by_id(options[:id])
  else
    Post.find_all(options[:limit], options[:type])
  end

if result.is_a? Post
  puts "Post #{result.class.name}, id = #{options[:id]}"

  result.to_strings.each do |line|
    puts line
  end
elsif result.nil?
  puts "Id #{id_input} did not find in db."
else
  print '| id                 '
  print '| @type              '
  print '| @created_at        '
  print '| @text              '
  print '| @url               '
  print '| @due_date          '
  print '|'

  result.each do |row|
    puts
    row.each do |element|
      element_text = "| #{element.to_s.delete("\n\r")[0..17]}"

      element_text << ' ' * (21 - element_text.size)

      print element_text
    end

    print '|'
  end
end

puts
