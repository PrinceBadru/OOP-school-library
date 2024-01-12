require_relative 'nameable_decorator'

class CapitalizeDecorator < NameableDecorator
  def correct_name
    @nameable.correct_name.capitalize
  end
end