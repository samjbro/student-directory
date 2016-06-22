require 'date'
@students = []

def interactive_menu
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
	when "1"
		input_student
	when "2"
		show_students
	when "3"
		save_students
	when "4"
		try_load_students
	when "9"
		exit
	else
		puts "I don't know what you mean - please try again"
	end
end

def input_student
	#cohort,hobby,height = :november, "unknown", "unknown"
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
	@students << {name: name, cohort: cohort.to_sym, height: height, hobby: hobby}
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
	file = File.open("students.csv", "w")
	@students.each do |student|
		student_data = [student[:name], student[:cohort], student[:hobby], student[:height]]
		csv_line = student_data.join(',')
		file.puts csv_line
	end
	file.close
end

def try_load_students
	filename = ARGV.first
	filename = "students.csv" if filename.nil?
	if File.exists?(filename)
		load_students(filename)
		puts "Loaded #{@students.count} from #{filename}"
	else
		abort "Sorry, #{filename} doesn't exist."
	end
end

def load_students(filename = "students.csv")
	file = File.open(filename, "r")
	file.readlines.each {|line| add_student(line)}
	file.close
end

def print_header cohort="2016"
	puts "The students of Villains Academy's #{cohort.capitalize} cohort".center(85)
	puts "-------------".center(85)
end

def print_students_list cohort="2016", letters="a".."z", character_max=100
	if cohort == "2016"
		names = @students
	else
		names = @students.select{|x| x[:cohort].downcase == cohort.to_sym.downcase}
	end
	(return puts "No students are in this cohort".center(85)) if names.empty?
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
	puts "Enter '2016' to see the year's full cohort"
	STDIN.gets.chomp
end

interactive_menu

