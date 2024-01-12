require_relative 'nameable'

class Person < Nameable
  attr_accessor :name, :age, :parent_permission
  attr_reader :id, :rentals, :classroom

  def initialize(age, name = 'Unknown', parent_permission: true)
    super()
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
    @classroom = nil
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def correct_name
    @name
  end

  def add_rental(date, book, person)
    Rental.new(date, book, person)
  end

  def to_h
    {
      class: self.class.name,
      name: @name,
      id: @id,
      age: @age,
      classroom: @classroom,
      parent_permission: @parent_permission,
      rentals: @rentals.map(&:to_h)
    }
  end

  private

  def of_age?
    @age.to_i >= 18
  end
end