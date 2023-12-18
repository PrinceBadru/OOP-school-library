require_relative 'Person'

class Teacher < Person
  def can_use_services?
    true
  end

  def initialize(specialization:, name: 'Unknown', age: 0)
    super(name: name, age: age)
    @specialization = specialization
  end
end
