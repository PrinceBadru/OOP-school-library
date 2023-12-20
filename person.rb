# person.rb

require_relative 'nameable'

class Person < Nameable
  attr_accessor :name, :age
  attr_reader :id

  @all_people = [] # Class instance variable to store all people

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
    @all_people ||= [] # Initialize if not already set
  end

  # Class method to find a person by ID
  def self.find(person_id)
    all.find { |person| person.id == person_id }
  end

  # Additional methods, if needed
end
