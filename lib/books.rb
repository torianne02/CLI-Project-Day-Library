class Book
  attr_accessor :title
  @@all = []

  def initialize(title)
    @title = title
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def self.empty_all
    @@all.clear
  end

  def self.create
    books = Scraper.books_array
    books.each do |book|
      book_title = book[:title]
    end
    new_book = self.new(book_title)
    new_book.save
    new_book
    binding.pry
  end
end