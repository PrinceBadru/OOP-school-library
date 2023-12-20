# main.rb

require_relative 'person'
require_relative 'capitalize_decorator'
require_relative 'trimmer_decorator'

# Define the entry point for the console app
def main
  loop do
    display_menu

    choice = gets.chomp.to_i

    case choice
    when 1
      run_decorator_example
    when 2
      puts 'Exiting the app. Goodbye!'
      break
    else
      puts 'Invalid choice. Please try again.'
    end
  end
end

# Displays the menu options to the user
def display_menu
  puts '------ Library App Menu ------'
  puts '1. Run Decorator Example'
  puts '2. Quit'
  print 'Enter your choice: '
end

# Run the example with decorators
# Run the example with decorators
def run_decorator_example
  person = Person.new(age: 22, name: 'maximilianus')
  puts "Original Name: #{person.correct_name}"

  capitalized_person = CapitalizeDecorator.new(person)
  puts "Capitalized Name: #{capitalized_person.correct_name}"

  capitalized_trimmed_person = TrimmerDecorator.new(capitalized_person)
  puts "Capitalized and Trimmed Name: #{capitalized_trimmed_person.correct_name}"
end

# Invoke the main method to start the console app
main
