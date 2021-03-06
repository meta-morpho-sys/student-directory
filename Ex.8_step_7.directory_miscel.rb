LINE_WIDTH = 120
MONTHS = [:january, :february, :march, :april, :may, :june, :july, :august, :september, :october, :november, :december]

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
  name = gets.chomp.upcase

  if name.empty? then name = '< Not provided >' end

  print "Cohort: "
  cohort = gets.chomp.downcase
  if cohort.empty? then cohort = '< Not provided >' end
  cohort = cohort.to_sym
  if !MONTHS.include? cohort
    puts 'Please, check spelling.'
  end

  print "Age: "
  age = gets.chomp

  print "Country of birth: "
  country_of_birth = gets.chomp.upcase!

  print "Height in cm: "
  height = gets.chomp

  print "Any hobbies? "
  hobbies = gets.chomp

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
  !input[:age].empty? && \
  !input[:born].empty? && \
  !input[:height].empty? && \
  !input[:hobbies].empty?
end

def want_to_continue?
  print "Do you wish to add another student [y/n]? "
  answer = gets.chomp
  'y' == answer
end

def input_students
  puts "Please enter the details of the students."
  puts "To finish just hit return twice."

  # Create an empty array.
  students = []
  input = get_user_input
  # Add the student hash to the array.
  students << input

  # While the input is valid repeat this code.
  # keep promting for more data UNTL the user
  # signals that they wish to stop by entrering an empty name
  while want_to_continue? do
    input = get_user_input

    # Add the student hash to the array.
    students << input
    puts "Now we have #{students.count} students."
  end
  # Return the array of students.
  students
end

def select_with(students, initial_letter_in_name)
  students.select { |element|
    element[:name].start_with? initial_letter_in_name
  }  # select a name if starts with specific letter
end

# This function selects strings with less than 12 characters.
# "students" is an array of hashes. Each hash contains the key ":name".
def less_than_12_characters(students)
  students.select { |h|
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
def print_list(students)
  students.each_with_index do |student, i|
    output = "#{i+1} #{student[:name]} - (#{student[:cohort]} cohort) - #{student[:age]} y.o. - #{student[:born]} - #{student[:height]} cm - #{student[:hobbies]}"
    output.center_puts
    puts
  end
end

def print_footer(students)
  "Overall we have #{students.count} great students.".center_puts
end

students = input_students
print_header
print_list(students)

puts "Please type here the initial letter of your research"
begin
  puts "(not lowercase)"
  letter = gets.chomp
end while letter.lowercase?

selected_students = select_with(students, letter)
print_list(selected_students)

puts "List of names with less than 12 characters"
selected_students = less_than_12_characters(students)
print_list(selected_students)

print_footer(students)
