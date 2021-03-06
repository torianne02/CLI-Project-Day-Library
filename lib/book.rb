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

  def self.create(title, book_url)
    self.new(title, book_url)
  end
end
