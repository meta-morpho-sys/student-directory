def input_students
  puts "Please enter the names of the students."
  puts "To finish just hit return twice."

  # Create an empty array.
  students = []
  # Get the first name.
  name = gets.chomp

  # While the name is not empty repeat this code.
  while !name.empty? do
    # Add the student hash to the array.
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students."
    # Get another name from user. If no, a continuous while loop will be triggered.
    name = gets.chomp
  end
  # Return the array of students.
  students
end

def print_header
  header = "The Students of Villains Academy"
  puts header
  puts "-" * header.length
end

def select_with(students, initial_letter_in_name)
  students.select { |element|
    element[:name].start_with? initial_letter_in_name
  }  # Select a name if starts with specific letter
end

# This function selects strings with less than 12 characters.
# "students" is an array of hashes. Each hash containts the key ":name".
def less_than_12_characters(students)
  students.select { |h|
    h[:name].length < 12
  }  # Select a name if less than 12 characters.
end

# This function will print the list of students using a "while" loop instead of "each" method.
def print_list(students)
  index = 0
  while index < students.length
    puts students[index][:name]
    index += 1
  end
end

def print_footer(students)
  puts "Overall we have #{students.count} great students."
end

students = input_students
print_header
print_list(students)

puts "Please type here the initial letter of your research"
letter = gets.chomp

selected_students = select_with(students, letter)
print_list(selected_students)

puts "List of names with less than 12 characters"
selected_students = less_than_12_characters(students)
print_list(selected_students)

print_footer(students)
