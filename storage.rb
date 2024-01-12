require 'json'

class Storage
  PEOPLE_FILE_PATH = 'people.json'.freeze
  BOOKS_FILE_PATH = 'books.json'.freeze
  RENTALS_FILE_PATH = 'rentals.json'.freeze

  class << self
    def read_people
      read_data(PEOPLE_FILE_PATH, Person)
    end

    def write_people(people)
      write_data(PEOPLE_FILE_PATH, people)
    end

    def read_books
      read_data(BOOKS_FILE_PATH, Book)
    end

    def write_books(books)
      write_data(BOOKS_FILE_PATH, books.map(&:to_h))
    end

    def read_rentals
      read_data(RENTALS_FILE_PATH, Rental)
    end

    def write_rentals(rentals)
      write_data(RENTALS_FILE_PATH, rentals.map(&:to_h))
    end

    private

    def read_data(file_path, entity_class)
      return [] unless File.exist?(file_path)

      data = parse_json(file_path)
      create_entities(data, entity_class)
    end

    def parse_json(file_path)
      json_data = File.read(file_path)
      JSON.parse(json_data, symbolize_names: true)
    end

    def create_entities(data, entity_class)
      data.map { |entry| instantiate_class(entry, entity_class) }
    end

    def instantiate_class(entry, entity_class)
      if entity_class == Book
        entity_class.new(entry[:title], entry[:author])
      else
        entity_class.new(entry)
      end
    rescue StandardError => e
      puts "Error creating entity: #{e.message}"
      nil
    end

    def write_data(file_path, data)
      json_data = JSON.pretty_generate(data)
      File.write(file_path, json_data)
    end
  end
end

class LibraryManager
  class << self
    def write_people(people)
      Storage.write_people(people)
    end

    def write_books(books)
      Storage.write_books(books)
    end

    def write_rentals(rentals)
      Storage.write_rentals(rentals)
    end
  end
end