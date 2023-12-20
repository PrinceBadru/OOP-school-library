# book.rb

class Book
    attr_accessor :title, :author
  
    @@all_books = []  # Class variable to store all books
  
    def initialize(title, author)
      @title = title
      @author = author
      @@all_books << self  # Add the book to the list when created
    end
  
    # Class method to retrieve all books
    def self.all
      @@all_books
    end
  
    # Additional methods, if needed
  end
  