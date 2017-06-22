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
  }  # select a name if starts with specific letter
end

def print_list(students)
  students.each_with_index do |student, i|
    puts "#{i+1} #{student[:name]} (#{student[:cohort]} cohort)"  # prints a number before the name of each student.
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

print_footer(students)
