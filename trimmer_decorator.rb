require_relative 'nameable_decorator'

class TrimmerDecorator < NameableDecorator
  def correct_name
    @nameable.correct_name[0, 10]
  end
end
