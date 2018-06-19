require_relative '../config/environment.rb'
require_relative '../lib/scraper.rb'
require_relative '../lib/books.rb'

class DayLibrary
  attr_accessor :chosen_book

  def calls_library
    puts "Welcome to the book library of best selling romance author, Sylvia Day."
    puts "Would you like to see a list of the books she has written? Please type 'yes' or 'no'."

    input = gets.chomp
    # input = 'yes'
    if input.downcase == "yes" || input.downcase == "y"
      choose_book
    elsif input.downcase == "no" || input.downcase == "n"
      puts "Thank you for using Sylvia Day's library. Goodbye."
    else
      puts "Invalid input. Please try again."
    end
  end

  def choose_book
    scraped_books = Scraper.new
    scraped_books.get_book_info
    books = scraped_books.books_array
    books.each {|book| Book.create(book[:title], book[:book_url])}
    Book.all.sort_by! {|book| book.title}
    Book.all.each {|book| puts "#{book.title}"}

    puts "Please type the title of the book you'd like to learn more about!"
    input = gets.chomp

    if Book.all_titles.include?(input)
      chosen_book = input
      return_description(chosen_book)
      start_over?
    else
      puts "Invalid input. Please try again."
    end
  end

  def return_description(chosen_book)
    grab_description = Scraper.new
    description = grab_description.get_description(chosen_book)
    return description
  end

  def start_over?
    puts "Would you like to see the list of books again? Please type 'yes' or 'no'."
    input = gets.chomp
    if input.downcase == "yes" || input.downcase == "y"
      choose_book
    elsif input.downcase == "no" || input.downcase == "n"
      puts "Thank you for using Sylvia Day's library. Goodbye."
    else
      puts "Invalid input. Please try again."
    end
  end
end