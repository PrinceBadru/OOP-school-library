# rental.rb
class Rental
  attr_reader :date, :book, :person

  @all_rentals = [] # Class instance variable to store all rentals

  def initialize(date, book, person)
    @date = date
    @book = book
    @person = person
    self.class.all << self # Add the rental to the list when created
  end

  # Class method to retrieve all rentals
  def self.all
    @all ||= [] # Initialize if not already set
  end

  # Additional methods, if needed
end
