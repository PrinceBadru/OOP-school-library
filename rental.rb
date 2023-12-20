# rental.rb

class Rental
  attr_reader :date, :book, :person

  def initialize(date, book, person)
    @date = date
    @book = book
    @person = person
  end

  # Additional methods, if needed
end
