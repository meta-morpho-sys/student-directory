# Let's put all students into an array.
students = [
  "Dr. Hannibal Lecter",
  "Darth Vader",
  "Nurse Ratched",
  "Michael Corleone",
  "Alex DeLarge",
  "The Wicked Witch of the West",
  "Terminator",
  "Freddy Krueger",
  "The Jocker",
  "Jeoffrey Baratheon",
  "Norman Bates"
]

def print_header
  puts "The Studends of Villains Academy"
  puts "--------------"
end

def print_list(names)
  names.each do |name|
    puts name
  end
end

def print_footer(names)
  puts "Overall we have #{names.count} great students."
end

print_header
print_list(students)
print_footer(students)
