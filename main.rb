require_relative 'app'
require_relative 'book'
require_relative 'student'
require_relative 'rental'
require_relative 'teacher'
require_relative 'menu'
require_relative 'storage'
require_relative 'person'

def main
  app = App.new
  run_menu(app)
end

main if __FILE__ == $PROGRAM_NAME