require_relative '../lib/scraper.rb'

class Book
  attr_accessor :title, :all_titles
  @@all = []
  @@all_titles = []

  def initialize(title = nil)
    @title = title
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

  def self.create(title)
    new_book = self.new(title)
    new_book.save
    new_book
  end
end


# a = Book.new('Entwined with You (Crossfire, #3)')
