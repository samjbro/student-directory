students = [
  {name: "Dr. Hannibal Lecter", cohort: :november, hobby: "Villainy", height: "Unknown"},
  {name: "Darth Vader", cohort: :november, hobby: "Villainy", height: "Unknown"},
  {name: "Nurse Ratched", cohort: :november, hobby: "Villainy", height: "Unknown"},
  {name: "Michael Corleone", cohort: :november, hobby: "Villainy", height: "Unknown"},
  {name: "Alex DeLarge", cohort: :november, hobby: "Villainy", height: "Unknown"},
  {name: "The Wicked Witch of the West", cohort: :november, hobby: "Villainy", height: "Unknown"},
  {name: "Terminator", cohort: :november, hobby: "Villainy", height: "Unknown"},
  {name: "Freddy Krueger", cohort: :november, hobby: "Villainy", height: "Unknown"},
  {name: "The Joker", cohort: :november, hobby: "Villainy", height: "Unknown"},
  {name: "Joffrey Baratheon", cohort: :november, hobby: "Villainy", height: "Unknown"},  
  {name: "Norman Bates", cohort: :november, hobby: "Villainy", height: "Unknown"}
]
def input_students
	puts "Please enter the names of the students"
	puts "To finish, just hit return twice"
	# create an empty array
	students = []
	# get the first name
	name = gets.chomp
	puts "Please enter the student's height"
	height = gets.chomp
	puts "Please enter the student's favourite hobby"
	hobby = gets.chomp
	# while the name is not empty, repeat this code
	while !name.empty? do 
		# add the student hash to the array
		students << {name: name, cohort: :november, height: height, hobby: hobby}
		puts "Now we have #{students.count} students"
		# get another name from the user
		name = gets.chomp
	end
	# return the array of students
	students
end

def print_header
	puts "The students of Villains Academy".center(85)
	puts "-------------".center(85)
end

def print names, letters="a".."z", character_max=100
	i = 0
	while i < names.length
		puts "#{i+1}. #{names[i][:name]} (#{names[i][:cohort]} cohort, Hobby: #{names[i][:hobby]}, Height: #{names[i][:height]})".center(85) if ((letters.include? names[i][:name][0].downcase) && (names[i][:name].length < character_max))
		i += 1
	end
end

def print_footer names
	puts "Overall, we have #{names.count} great students".center(85)
end


#students = input_students
print_header
print students#, "d", 12
print_footer students
