class Student < Person
  attr_accessor :classroom

  def initialize(age, name: 'Unknown', parent_permission: true)
    super(age, name, parent_permission)
    @classroom = nil
  end
end
