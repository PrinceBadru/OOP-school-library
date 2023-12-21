require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rental'

class App
  attr_accessor :books, :people, :rentals

  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def list_books
    @books.each { |book| puts "Title: \"#{book.title}\", Author: #{book.author}" }
  end

  def list_people
    @people.each do |person|
      puts "[#{person.class.name}] \"#{person.name}\", ID: #{person.id}, Age: #{person.age}"
    end
  end

  def list_rentals
    print 'Enter Person ID: '
    id = gets.chomp.to_i
    record = @rentals.find_all { |rental| rental.person.id == id }
    if record.nil?
      puts 'ID not found!'
      return
    end
    puts "Rentals found with ID: #{id}"
    record.map { |rental| puts "Date: #{rental.date} - Book \"#{rental.book.title}\" by #{rental.book.author}" }
  end

  def create_person
    print 'Do you want to create a student (1) or a Teacher (2)? [Input the number]: '
    person = gets.chomp.to_i
    if person == 1
      create_student
    elsif person == 2
      create_teacher
    else
      puts "#{person} is an nvalid option! "
    end
  end

  def create_student
    print 'Age: '
    age = gets.chomp.to_i

    print 'Name: '
    name = gets.chomp.to_s

    print 'Has parent permission? [Y/N]: '
    parent_permission = gets.chomp.to_s

    if parent_permission =~ /^[Yy]/
      student = Student.new('Unknown', age, name, parent_permission: true)
    elsif parent_permission =~ /^[Nn]/
      student = Student.new('Unknown', age, name, parent_permission: false)
    else
      puts 'Ivalid Value!!'
      return
    end

    @people.push(student)
    puts 'Person Created Successfully'
  end

  def create_teacher
    print 'Age: '
    age = gets.chomp.to_i

    print 'Name: '
    name = gets.chomp.to_s

    print 'Specialization: '
    specialization = gets.chomp.to_s

    teacher = Teacher.new(specialization, age, name)
    @people.push(teacher)
    puts 'Person Created Successfully'
  end

  def create_book
    print 'Title: '
    title = gets.chomp.to_s

    print 'Author: '
    author = gets.chomp.to_s

    book = Book.new(title, author)
    @books.push(book)
    puts 'Book created successfully'
  end

  def list_books_with_index
    @books.each_with_index do |book, i|
      puts "#{i}) Title: \"#{book.title}\", Author: #{book.author}"
    end
  end

  def list_people_with_index
    @people.each_with_index do |person, i|
      puts "#{i}) [#{person.class.name}] Name: \"#{person.name}\", ID: #{person.id}, Age: #{person.age}"
    end
  end

  def create_rental
    puts 'Select Book from the following list by number'
    list_books_with_index
    book_id = gets.chomp.to_i
    unless (0..@books.length).include?(book_id)
      puts "Can't add rental record! Book #{book_id} doesn't exist"
      return
    end

    book = @books[book_id]
    puts "\nSelect a person from the following list by number"
    list_people_with_index
    person_index = gets.chomp.to_i
    unless (0..@people.length).include?(person_index)
      puts "Can't add a record! Person doesn't exist"
      return
    end
    person = @people[person_index]
    print 'Date: '
    date = gets.chomp.to_s
    @rentals.push(Rental.new(date, book, person))
    puts 'Rental Created successfully'
  end

  def run
    prompt
  end
end