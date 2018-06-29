require_relative '../lib/scraper.rb'

class DayBooks::Book
  attr_accessor :title, :book_url
  @@all = []

  def initialize(title = nil, book_url = nil)
    @title = title
    @book_url = book_url
    @@all << self
  end

  def self.all
    @@all
  end

  def self.downcase_all_titles
    @@all.map {|book| book.title.downcase}
  end

  def self.create(title, book_url)
    new_book = self.new(title, book_url)
    new_book
  end
end
