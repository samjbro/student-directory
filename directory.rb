require 'date'
require 'csv'
@students = []

def interactive_menu
	init_load_students
	loop do
		print_menu
		process(STDIN.gets.chomp)
	end
end

def print_menu
	puts "1. Input the students"
	puts "2. Show the students"
	puts "3. Save the directory"
	puts "4. Load the saved directory"
	puts "9. Exit"
end

def process selection
	case selection
	when "1"; input_student
	when "2"; show_students
	when "3"; save_students
	when "4"; choose_load_students
	when "9"; abort("You have exited the directory")
	else; puts "I don't know what you mean - please try again"
	end
end

def input_student
	puts "Please enter the student's NAME,COHORT,HOBBY,HEIGHT"
	add_student(STDIN.gets)
	plural = ""
	plural = "s" if (@students.count > 1)
	puts "Now we have #{@students.count} student#{plural}"
end

def add_student data_arr
	return if data_arr.empty?
	name, cohort, height, hobby = data_arr.chomp.split(',')
	cohort = check_valid_month(cohort, name)
	student = {name: name, cohort: cohort.to_sym, height: height, hobby: hobby} 
	if !@students.include?(student)
		@students << student
		puts "#{name} was added to the directory!"
	else
		puts "#{name} is already in the directory."
	end 
end

def check_valid_month cohort, name
	return cohort unless !Date::MONTHNAMES[1..-1].include? cohort.to_s.capitalize
	puts "Please re-enter #{name}'s cohort"
	cohort = STDIN.gets.chomp
	cohort = :none if cohort == nil
	check_valid_month cohort, name
end

def show_students
	cohort = choose_cohort
	print_header cohort
	print_students_list cohort
	print_footer
end

def save_students
	puts "Which file would you like to save to?"
	CSV.open(STDIN.gets.chomp, "wb") do |csv|
		@students.each {|student| csv << [student[:name], student[:cohort], student[:hobby], student[:height]]}
	end
	puts "The directory was saved."
end

def init_load_students
	if ARGV.empty?
		puts "No save file supplied - Load default file? Y/N"
		input = STDIN.gets.chomp
		case input.upcase
		when 'Y'
			puts "Loading default save file: 'students.csv'"
			return load_students
		else
			puts "Opening blank directory:"
		end
	else 
		filename = ARGV.first
		load_students(filename)
	end
end

def choose_load_students
	puts "Which file would you like to load?"
	saved_file = STDIN.gets.chomp
	return load_students(saved_file) if File.exists?(saved_file)
	puts "Sorry, '#{saved_file}' doesn't exist."
end

def load_students(filename="students.csv")
	puts "Loading students from #{filename}:"
	CSV.foreach(filename) {|line| add_student(line.join(','))}
end

def print_header cohort="2016"
	puts "The students of Villains Academy's #{cohort.capitalize} cohort".center(85)
	puts "-------------".center(85)
end

def print_students_list cohort="2016", letters="a".."z", character_max=100
	cohort == "2016" ? (names = @students) : (names = @students.select{|x| x[:cohort].downcase == cohort.to_sym.downcase})
	return puts "No students are in this cohort".center(85) if names.empty?
	names.each_with_index do |name,i|
		puts "#{i+1}. #{names[i][:name]} (Cohort: #{names[i][:cohort].capitalize}, Hobby: #{names[i][:hobby]}, Height: #{names[i][:height]})".center(85) if ((letters.include? names[i][:name][0].downcase) && (names[i][:name].length < character_max))
	end
end

def print_footer cohort=:november
	plural = ""
	plural = "s" if (@students.count > 1)
	puts "Overall, we have #{@students.count} great student#{plural} in the #{cohort.capitalize} cohort".center(85)
end

def choose_cohort
	puts "Which month's cohort would you like to see?"
	puts "Enter '2016' to see the year's full cohort"
	STDIN.gets.chomp
end

interactive_menu

