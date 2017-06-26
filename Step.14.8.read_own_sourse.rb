def give_name_of_called_script(filename)
  puts "Loaded from #{filename}"
  puts "$0            Gives the name of the called script   : #{$0}"
  puts "__FILE__      Gives the name of the called script   : #{__FILE__}"
  puts "$PROGRAM_NAME Gives the name of the called script   : #{$PROGRAM_NAME}"
  puts
end

def read_own_sourse
  filename = ARGV.first      # First argument from the command line.
  return if filename.nil?    # Get out of the method if it isn't given.
  if File.exists?(filename)  # If it exists...
    give_name_of_called_script(filename)
    file = File.open(filename, 'r')
    file.readlines.each do |line|
      puts line
    end
    file.close()
  else                       # If it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit                     # Quit the program.
  end
end


read_own_sourse
