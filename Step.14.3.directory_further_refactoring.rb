LINE_WIDTH = 120
MONTHS = [:january, :february, :march, :april, :may, :june, :july, :august, :september, :october, :november, :december]
DATA_FILENAME = 'students.csv'
@students = []

def try_load_students
  filename = ARGV.first || filename = DATA_FILENAME   # First argument from the command line.
  return if filename.nil?    # Get out of the method if it isn't given.
  if File.exists?(filename)  # If it exists...
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else                       # If it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit                     # Quit the program.
  end
end

def print_menu
  puts '1. Input the students'
  puts '2. Show the students.'
  puts '3. Save list to students.csv.'
  puts '4. Load the list from students.csv.'
  puts '9. Exit.'  # 9 because we'll be adding more items.
  puts
end

def show_students
  print_header
  print_list @students
  print_footer
end

def save_students(filename = DATA_FILENAME)
  file = File.open(filename, 'w')  # Open file for writing.
  @students.each do |student|      # Iterate over an array of students.
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(',')
    file.puts csv_line
  end
  file.close
end

def load_students(filename = DATA_FILENAME)
  file = File.open(filename, 'r')
  file.readlines.each do |line|
    name, cohort = line.chomp.split(',')
      @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

def process(selection)
  case selection
    when '1'
      input_students  # Input the students.
    when '2'
      show_students  # Show the students.
    when '3'
      save_students  # Save students into file.
    when '4'
      load_students  # Read students from file.
    when '9'
      exit           # This will cause the program to terminate.
    else
      puts "I don't know what you mean. Try again."
  end
end

def interactive_menu

  loop do
    print_menu                          # Print the menu and ask the user what to do.
    process(STDIN.gets.chomp)  # Execute what the user has asked.
  end
end

class String
  def lowercase?
    self.downcase == self
  end

  def center_puts
    puts self.center(LINE_WIDTH)
  end
end

# Prompts user for details (name, age...) and returns a hash.
def get_user_input
  print "Name: "
  name = STDIN.gets.chomp.upcase
  if name.empty? then name = '< Not provided >' end

  print "Cohort: "
  cohort = STDIN.gets.chomp.downcase
  if cohort.empty? then cohort = '< Not provided >' end
  cohort = cohort.to_sym
  if !MONTHS.include? cohort
    puts 'Please, check spelling.'
  end

  print "Age: "
  age = STDIN.gets.chomp.to_s
  if age.empty? then age = '< Not provided >' end

  print "Country of birth: "
  country_of_birth = STDIN.gets.chomp.upcase!
  if country_of_birth && country_of_birth.empty? then country_of_birth = '< Not provided >' end

  print "Height in cm: "
  height = STDIN.gets.chomp
  if height.empty? then height = '< Not provided >' end

  print "Any hobbies? "
  hobbies = STDIN.gets.chomp
  if hobbies.empty? then hobbies = '< Not provided >' end

   {
    name: name,
    cohort: cohort,
    age: age,
    born: country_of_birth,
    height: height,
    hobbies: hobbies
  }
end

# This function returns true if the input hash is valid, i.e.
# if all the required keys have values that are not empty strings
# (returns false otherwise)
def valid_input? input
  !input[:name].empty? && \
  !input[:cohort].empty? && \
  !input[:age].empty? && \
  !input[:born].empty? && \
  !input[:height].empty? && \
  !input[:hobbies].empty?
end

def want_to_continue?
  print "Do you wish to add a student [y/n]? "
  answer = STDIN.gets.chomp
  'y' == answer
end

def input_students
  puts "Please enter the details of the students."

  # While the input is valid repeat this code.
  # Keep prompting for more data UNTL the user
  # signals that they wish to stop by entering an empty name.
  while want_to_continue?
    input = get_user_input
    @students << input    # Add the student hash to the array.
    plural_expression = @students.length == 1 ? '' : 's'
    puts "Now we have #{@students.count} student#{plural_expression}."
  end
  @students   # Return the array of students.
end

def select_with(initial_letter_in_name)
  @students.select { |element|
    element[:name].start_with? initial_letter_in_name
  }  # select a name if starts with specific letter
end

# Selects strings with less than 12 characters.
# "students" is an array of hashes. Each hash contains the key ":name".
def less_than_12_characters()
  @students.select { |h|
    h[:name].length < 12
  }
end

def print_header
  header = "The Students of Villains Academy"
  header.center_puts
  ('-' * header.length).center_puts
end

# Prints a number before the name of each student.
# Prints name, age, place of birth, height, hobbies.
def print_list students
  students.each_with_index do |student, i|
    output = "#{i+1} #{student[:name]} - (#{student[:cohort]} cohort) - #{student[:age]} y.o. - #{student[:born]} - #{student[:height]} cm - #{student[:hobbies]}"
    output.center_puts
    puts
  end
end

def print_footer
  "Overall we have #{@students.count} great students.".center_puts
end

# Main entry point to the application.
def main
  try_load_students
  interactive_menu
  input_students
  print_header

  if @students.empty?
    puts 'No users were entered!'
  else
    print_list @students
  end

  puts "Please type here the initial letter of your research"
  begin
    puts "(not lowercase)"
    letter = gets.chomp
  end while letter.lowercase?

  selected_students = select_with(letter)
  print_list selected_students

  puts "List of names with less than 12 characters"
  selected_students = less_than_12_characters
  print_list selected_students

  print_footer
end

main