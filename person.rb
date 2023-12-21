# person.rb
require_relative 'nameable'

class Person < Nameable
  attr_accessor :name, :age
  attr_reader :id, :parent_permission

  # Class variable to store all people
  @@all_people = []

  def initialize(age:, name: 'Unknown', parent_permission: true)
    super()
    @id = Random.rand(1..1000)
    @age = age
    @name = name
    @parent_permission = parent_permission
    self.class.all << self # Add the person to the list when created
  end

  # Class method to retrieve all people
  def self.all
    @@all_people ||= [] # Initialize if not already set
  end

  # Class method to find a person by ID
  def self.find(person_id)
    all.find { |person| person.id == person_id }
  end

  def rentals
    Rental.all.select { |rental| rental.person == self }
  end

  # Additional methods, if needed
end
