require 'date'
students = [
  {name: "Dr. Hannibal Lecter", cohort: :january, hobby: "Villainy", height: "Unknown"},
  {name: "Darth Vader", cohort: :january, hobby: "Villainy", height: "Unknown"},
  {name: "Nurse Ratched", cohort: :january, hobby: "Villainy", height: "Unknown"},
  {name: "Michael Corleone", cohort: :january, hobby: "Villainy", height: "Unknown"},
  {name: "Alex DeLarge", cohort: :november, hobby: "Villainy", height: "Unknown"},
  {name: "The Wicked Witch of the West", cohort: :november, hobby: "Villainy", height: "Unknown"},
  {name: "Terminator", cohort: :november, hobby: "Villainy", height: "Unknown"},
  {name: "Freddy Krueger", cohort: :november, hobby: "Villainy", height: "Unknown"},
  {name: "The Joker", cohort: :november, hobby: "Villainy", height: "Unknown"},
  {name: "Joffrey Baratheon", cohort: :november, hobby: "Villainy", height: "Unknown"},  
  {name: "Norman Bates", cohort: :november, hobby: "Villainy", height: "Unknown"}
]
@students = []
def interactive_menu
	loop do
		print_menu
		process(gets.chomp)
	end
end

def print_menu
	puts "1. Input the students"
	puts "2. Show the students"
	puts "3. Save the directory"
	puts "9. Exit"
end

def process selection
	case selection
	when "1"
		input_student
	when "2"
		show_students
	when "3"
		save_students
	when "9"
		exit
	else
		puts "I don't know what you mean - please try again"
	end
end

def show_students
	print_header
	print_students_list
	print_footer
end

def input_student
	cohort,hobby,height = :november, "unknown", "unknown"
	puts "Please enter the student's NAME/COHORT/HOBBY/HEIGHT"
	input = gets.chomp.split('/')
	return @students if input.empty?
	name = input[0]
	cohort = input[1] unless input[1] == nil
	hobby = input[2] unless input[2] == nil
	height = input[3] unless input[3] == nil
	if !Date::MONTHNAMES[1..-1].include? cohort.capitalize
		puts "Please re-enter the student's cohort"
		cohort = gets.chomp
		if !Date::MONTHNAMES[1..-1].include? cohort.capitalize
			cohort = :november
			puts "Invalid input - default of 'November' assigned"
		end
	end
	@students << {name: name, cohort: cohort.to_sym, height: height, hobby: hobby}
	plural = ""
	plural = "s" if (@students.count > 1)
	puts "Now we have #{@students.count} student#{plural}"
end

def save_students
	file = File.open("students.csv", "w")
	@students.each do |student|
		student_data = [student[:name], student[:cohort], student[:height], student[:hobby]]
		csv_line = student_data.join(',')
		file.puts csv_line
	end
	file.close
end

def print_header cohort=:november
	puts "The students of Villains Academy's #{cohort.capitalize} cohort".center(85)
	puts "-------------".center(85)
end

def print_students_list cohort=:november, letters="a".."z", character_max=100
	names = @students.select{|x| x[:cohort].downcase == cohort.to_sym.downcase}
	(return puts "No students are on this cohort".center(85)) if names.empty?
	i = 0
	while i < names.length
		puts "#{i+1}. #{names[i][:name]} (Cohort: #{names[i][:cohort].capitalize}, Hobby: #{names[i][:hobby]}, Height: #{names[i][:height]})".center(85) if ((letters.include? names[i][:name][0].downcase) && (names[i][:name].length < character_max))
		i += 1
	end
end

def print_footer cohort=:november
	plural = ""
	plural = "s" if (@students.count > 1)
	puts "Overall, we have #{@students.count} great student#{plural} in the #{cohort.capitalize} cohort".center(85)
end

def choose_cohort
	puts "Which month's cohort would you like to see?"
	gets.chomp
end

# @students = input_@students
# cohort = "november"
# cohort = choose_cohort
# print_header(cohort)
# print(@students, cohort,)#"d", 12)
# print_footer(@students, cohort)
interactive_menu

