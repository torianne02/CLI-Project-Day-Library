require_relative '../lib/scraper.rb'

class Book
  attr_accessor :title, :all_titles, :book_url
  @@all = []
  @@all_titles = []

  def initialize(title = nil, book_url = nil)
    @title = title
    @book_url = book_url
  end

  def self.all
    @@all
  end

  def self.all_titles
    @@all_titles
  end

  def save
    @@all << self
    @@all_titles << @title
  end

  def self.empty_all
    @@all.clear
    @@all_titles.clear
  end

  def self.create(title, book_url)
    new_book = self.new(title, book_url)
    new_book.save
    new_book
  end
end


# a = Book.new('Entwined with You (Crossfire, #3)')
