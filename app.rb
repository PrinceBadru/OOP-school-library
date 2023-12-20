require_relative 'book'
require_relative 'person'
require_relative 'rental'

class App
    def self.run
      main_menu
    end
  
    def self.main_menu
      loop do
        display_main_menu
  
        choice = gets.chomp.to_i
  
        case choice
        when 1
          list_all_books
        when 2
          list_all_people
        when 3
          create_person
        when 4
          create_book
        when 5
          create_rental
        when 6
          list_rentals_for_person
        when 7
          puts 'Exiting the app. Goodbye!'
          break
        else
          puts 'Invalid choice. Please try again.'
        end
      end
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
      print 'Enter person name: '
      name = gets.chomp
      print 'Enter person age: '
      age = gets.chomp.to_i
      print 'Is parent permission granted? (true/false): '
      parent_permission = gets.chomp.downcase == 'true'
      
      person = Person.new(age: age, name: name, parent_permission: parent_permission)
      puts "Person #{person.name} created with ID: #{person.id}"
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
      print 'Enter person ID for rental: '
      person_id = gets.chomp.to_i
      person = Person.find(person_id)
    
      if person.nil?
        puts 'Person not found.'
        return
      end
    
      print 'Enter book title for rental: '
      book_title = gets.chomp
      book = Book.find_by_title(book_title)
    
      if book.nil?
        puts 'Book not found.'
        return
      end
    
      print 'Enter rental date: '
      date = gets.chomp
    
      rental = Rental.new(date, book, person)
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
  