9LINE_WIDTH = 120
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
  # Open file for writing.
  file = File.open(filename, 'w')
  # Iterate over an array of students.
  @students.each do |student|
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
      # Input the students.
      input_students
    when '2'
      # Show the students.
      show_students
    when '3'
      # Save students into file.
      save_students
    when '4'
      # Read students from file.
      load_students
    when '9'
      exit # This will cause the program to terminate.
    else
      puts "I don't know what you mean. Try again."
  end
end

def interactive_menu

  loop do
    # 1. Print the menu and ask the user what to do.
    print_menu
    # 2. Execute what the user has asked.
    process(STDIN.gets.chomp)
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
  age = STDIN.gets.chomp

  print "Country of birth: "
  country_of_birth = STDIN.gets.chomp.upcase!

  print "Height in cm: "
  height = STDIN.gets.chomp

  print "Any hobbies? "
  hobbies = STDIN.gets.chomp

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

    # Add the student hash to the array.
    @students << input

    plural_expression = @students.length == 1 ? '' : 's'
    puts "Now we have #{@students.count} student#{plural_expression}."

    # students.length > 1 ? print_list(students) : (puts 'The list is empty!')

  end
  # Return the array of students.
  @students
end

def select_with(initial_letter_in_name)
  @students.select { |element|
    element[:name].start_with? initial_letter_in_name
  }  # select a name if starts with specific letter
end

# This function selects strings with less than 12 characters.
# "students" is an array of hashes. Each hash contains the key ":name".
def less_than_12_characters()
  @students.select { |h|
    h[:name].length < 12
  }  # Select a name if less than 12 characters.
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