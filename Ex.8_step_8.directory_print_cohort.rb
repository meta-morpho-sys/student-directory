MONTHS = [:january, :february, :march, :april, :may, :june, :july, :august, :september, :october, :november, :december]
# found_month = MONTHS.select{|month| month == :january}
# puts found_month

students = [
    {name: "Dr. Hannibal Lecter", cohort: :january},
    {name: "Darth Vader", cohort: :november},
    {name: "Nurse Ratched", cohort: :november},
    {name: "Michael Corleone", cohort: :july},
    {name: "Alex DeLarge", cohort: :july},
    {name: "The Wicked Witch of the West", cohort: :may},
    {name: "Terminator", cohort: :may},
    {name: "Freddy Krueger", cohort: :february},
    {name: "The Joker", cohort: :november},
    {name: "Joffrey Baratheon", cohort: :july},
    {name: "Norman Bates", cohort: :november}
]

# found_cohort = students.select { |student| student[:cohort] == :november}
# puts found_cohort

  MONTHS.each { |month|
    puts students.select { |student| student[:cohort] == month }
    puts
  }
