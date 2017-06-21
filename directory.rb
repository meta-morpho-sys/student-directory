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

puts "The Students of Villains Academy"
puts "--------------"
students.each do |student|
  puts student
end

# Here we print the total number of the students.
puts "Overall we have #{students.count} great students."
