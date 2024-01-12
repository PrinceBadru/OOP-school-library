require_relative 'book'
require_relative 'classroom'
require_relative 'person'
require_relative 'rental'
require_relative 'student'
require_relative 'teacher'
require_relative 'input'
require_relative 'menu'
require_relative 'storage'

class App
  attr_accessor :books, :people, :rentals

  def initialize
    @books = Storage.read_books
    @rentals = Storage.read_rentals
    @people = Storage.read_people
  end

  def list_books
    if @books.empty?
      puts 'Currently, there are no books!'
      prompt
    else
      @books.each_with_index do |book, i|
        puts "#{i}) [#{book.class.name}] Title: #{book.title}, Author: #{book.author}"
      end
    end
  end

  def list_people
    if @people.empty?
      puts 'Currently, there are no people in this library / school!'
      prompt
    else
      filtered_people = @people.select { |person| person.is_a?(Student) || person.is_a?(Teacher) }
  
      if filtered_people.empty?
        puts 'No students or teachers found!'
      else
        filtered_people.each_with_index do |person, i|
          class_info = person.is_a?(Student) ? "Class: #{person.classroom}" : "Specialization: #{person.specialization}"
          puts "#{i}) [#{person.class.name}] Name: #{person.age}, ID: #{person.id}, Age:#{person.name} , #{class_info}"
        end
      end
    end
  end
  
# Modify add_student method
def add_student
  puts 'Class:'
  age = get_user_input_integer('')
  puts 'Name:'
  name = get_user_input('')
  puts 'Age:'
  classroom = get_user_input('')
  parent_permission = obtain_parent_permission

  # Ensure to pass the correct arguments to the Student constructor
  @people.push(Student.new(age, name, classroom, parent_permission: parent_permission))
  LibraryManager.write_people(@people)
  puts 'Person created successfully'
end


# Modify add_teacher method
def add_teacher
  puts 'Specialization: '
  age = get_user_input_integer('')
  puts 'Name: '
  name = get_user_input('')
  puts 'Age: '
  specialization = get_user_input('')

  parent_permission = obtain_parent_permission

  # Ensure to pass the correct arguments to the Teacher constructor
  @people.push(Teacher.new(age, name, specialization, parent_permission: parent_permission))
  LibraryManager.write_people(@people)
  puts 'Person created successfully'
end


  def add_person
    puts 'Do you want to create a student (1) or a teacher (2)? [input the number]: '
    person_type = get_user_input_integer('')

    case person_type
    when 1
      add_student
    when 2
      add_teacher
    else
      puts 'Invalid choice. Please choose option 1 or option 2.'
      prompt
    end
  end

  def add_book
    puts 'Title:'
    title = get_user_input('')
    puts 'Author:'
    author = get_user_input('')

    @books.push(Book.new(title, author))
    LibraryManager.write_books(@books)
  end

  def add_rental
    puts 'Select a book from the following list by number:'
    list_books
    book_idx = get_user_input_integer('')

    book = find_item_by_index(book_idx, @books, 'Book')
    return unless book

    puts 'Select a person from the following list by number (not id)'
    list_people
    person_idx = get_user_input_integer('')

    person = find_item_by_index(person_idx, @people, 'Person')
    return unless person

    print 'Date: '
    date = get_user_input('')
    LibraryManager.write_rentals(rentals)
    handle_rental_creation(date, book, person)
  end

  def handle_rental_creation(date, book, person)
    rental = Rental.new(date, book, person)

    if @rentals.length >= 20
      puts 'Error: Maximum number of rentals reached (20). Cannot add more rentals.'
    else
      @rentals.push(rental)
      LibraryManager.write_rentals(@rentals)
      puts 'Rental created successfully'
    end
  end

  def find_item_by_index(index, collection, item_type)
    if (0...collection.length).include?(index)
      collection[index]
    else
      puts "Error adding a record. #{item_type} #{index} doesn't exist"
      nil
    end
  end

  def list_rental
    puts 'ID of person: '
    id = get_user_input_integer('')
    filtered = @rentals.find_all { |rental| rental.person.id == id }

    if filtered.empty?
      puts "Person with given id #{id} does not exist"
    else
      puts 'Rentals:'
      filtered.each do |rental|
        puts "Date: #{rental.date}, Book \"#{rental.book.title}\" by #{rental.book.author}"
      end
    end
  end

  def quit_app
    LibraryManager.write_people(@people)
    puts 'Thank you. See you soon'
  end

  private

  def obtain_parent_permission
    puts 'Has parent permission? [Y / N]: '
    parent_permission = get_user_input('').capitalize

    case parent_permission
    when /^[Yy]/
      true
    when /^[Nn]/
      false
    else
      puts "Invalid choice. Please enter a valid option. (#{parent_permission})"
      obtain_parent_permission
    end
  end

  def prompt
    run_menu(self)
  end

  def run
    prompt
  end
end