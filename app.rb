require_relative 'book'
require_relative 'person'
require_relative 'rental'
require_relative 'teacher'
require_relative 'student'

class App
  def self.run
    main_menu
  end

  def self.main_menu
    loop do
      display_main_menu
      process_choice(gets.chomp.to_i)
    end
  end

  def self.process_choice(choice)
    choices = {
      1 => :list_all_books,
      2 => :list_all_people,
      3 => :create_person,
      4 => :create_book,
      5 => :create_rental,
      6 => :list_rentals_for_person,
      7 => :exit_app
    }

    method_name = choices[choice]
    method_name.nil? ? invalid_choice : send(method_name)
  end

  def self.invalid_choice
    puts 'Invalid choice. Please try again.'
  end

  def self.exit_app
    puts 'Exiting the app. Goodbye!'
    exit
  end

  def self.display_main_menu
    puts '------ Library App Main Menu ------'
    puts '1. List all books'
    puts '2. List all people'
    puts '3. Create a person'
    puts '4. Create a book'
    puts '5. Create a rental'
    puts '6. List all rentals for a person'
    puts '7. Quit'
    print 'Enter your choice: '
  end

  def self.list_all_books
    puts 'List of Books:'
    Book.all.each do |book|
      puts "#{book.title} by #{book.author}"
    end
  end

  def self.list_all_people
    puts 'List of People:'
    Person.all.each do |person|
      puts "#{person.name} (ID: #{person.id})"
    end
  end

  def self.create_person
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    role_choice = gets.chomp.to_i

    case role_choice
    when 1
      create_student
    when 2
      create_teacher
    else
      puts 'Invalid choice. Please try again.'
    end
  end

def self.create_student
  print 'Enter student name: '
  name = gets.chomp
  print 'Enter student age: '
  age = gets.chomp.to_i
  print 'Enter student classroom: '
  classroom = gets.chomp
  print 'Is parent permission granted? (true/false): '
  parent_permission = gets.chomp.downcase == 'true'

  student = Student.new(age: age, classroom: classroom, name: name, parent_permission: parent_permission)
  puts "Student #{student.name} created with ID: #{student.id}"
end

  def self.create_teacher
    print 'Enter teacher name: '
    name = gets.chomp
    print 'Enter teacher age: '
    age = gets.chomp.to_i
    print 'Enter teacher specialization: '
    specialization = gets.chomp

    teacher = Teacher.new(age: age, name: name, specialization: specialization)
    puts "Teacher #{teacher.name} created with ID: #{teacher.id}"
  end

  def self.create_book
    print 'Enter book title: '
    title = gets.chomp
    print 'Enter book author: '
    author = gets.chomp

    book = Book.new(title, author)
    puts "Book #{book.title} by #{book.author} created."
  end

  def self.create_rental
    display_available_books
  
    print 'Select a book by entering the corresponding index: '
    book_index = gets.chomp.to_i
    selected_book = Book.all[book_index]
  
    if selected_book.nil?
      puts 'Invalid book selection.'
      return
    end
  
    print 'Enter rental date: '
    date = gets.chomp
  
    print 'Enter person ID for rental: '
    person_id = gets.chomp.to_i
    person = Person.find(person_id)
  
    if person.nil?
      puts 'Person not found.'
      return
    end
  
    create_and_display_rental(date, selected_book, person)
  end
  
  def self.display_available_books
    puts 'Available Books for Rental:'
    Book.all.each_with_index do |book, index|
      puts "#{index}) Title: \"#{book.title}\", Author: #{book.author}"
    end
  end

  def self.create_and_display_rental(date, book, person)
    Rental.new(date, book, person)
    puts "Rental created for #{person.name} - #{book.title} on #{date}."
  end

  def self.list_rentals_for_person
    print 'Enter person ID: '
    person_id = gets.chomp.to_i
    person = Person.find(person_id)

    if person.nil?
      puts 'Person not found.'
      return
    end

    puts "Rentals for #{person.name}:"
    person.rentals.each do |rental|
      puts "#{rental.book.title} on #{rental.date}"
    end
  end
end

# Run the app
App.run
