require_relative 'Person'

class Student < Person
  def play_hooky
    '¯\\(ツ)/¯'
  end

  def initialize(classroom:, name: 'Unknown', age: 0, parent_permission: true)
    super(name: name, age: age, parent_permission: parent_permission)
    @classroom = classroom
  end
end
