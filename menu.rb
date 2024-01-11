require_relative 'input'

def options
  puts 'Please choose an option by entering a number:'
  puts '1 - List all books'
  puts '2 - List all people'
  puts '3 - Create a person'
  puts '4 - Create a book'
  puts '5 - Create a rental'
  puts '6 - List all rentals for a given person id'
  puts '7 - Exit'
end

def call_option(option, app)
  case option
  when 1
    app.list_books
  when 2
    app.list_people
  when 3
    app.add_person
  when 4
    app.add_book
  when 5
    app.add_rental
  when 6
    app.list_rental
  else
    puts 'Thanks for using the School Library App!'
  end
end

def run_menu(app)
  loop do
    options
    option = get_user_input_integer('Enter your choice: ')
    call_option(option, app)
    break if option == 7
  end
end
