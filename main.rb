# option_handler.rb
class OptionHandler
  def initialize(library)
    @library = library
  end

  def handle_option(option)
    case option
    when 1
      @library.list_books
    when 2
      @library.list_people
    when 3
      @library.create_person
    when 4
      @library.create_book
    when 5
      @library.create_rental
    when 6
      @library.list_rentals
    else
      puts 'Choose between 1 - 7'
    end
  end
end

# library.rb
class Library
  def initialize
    # Initialize your library instance variables here
  end

  def list_books
    # Implementation for listing books
  end

  def list_people
    # Implementation for listing people
  end

  def create_person
    # Implementation for creating a person
  end

  def create_book
    # Implementation for creating a book
  end

  def create_rental
    # Implementation for creating a rental
  end

  def list_rentals
    # Implementation for listing rentals
  end
end

# user_interface.rb
class UserInterface
  def self.all_options
    puts "\nPlease choose an option by entering a number:\n
    1 - List all Books\n
    2 - List all People\n
    3 - Create a Person\n
    4 - Create a Book\n
    5 - Create a Rental\n
    6 - List all rentals for a given person id\n
    7 - Exit"
  end

  def self.prompt
    puts 'Welcome to School Library App!'
  end
end

# main.rb
require_relative 'library'
require_relative 'option_handler'
require_relative 'user_interface'

class Main
  def initialize
    @library = Library.new
    @option_handler = OptionHandler.new(@library)
  end

  def run
    UserInterface.prompt
    loop do
      UserInterface.all_options
      option = gets.chomp.to_i
      break if option == 7

      @option_handler.handle_option(option)
    end
  end
end

# Instantiate Main class and run the application
Main.new.run
