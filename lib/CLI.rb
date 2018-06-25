require_relative '../config/environment.rb'
require_relative '../lib/day_books/version.rb'

class DayBooks::CLI
  attr_accessor :chosen_book

  def call
    puts "Welcome to the book library of best selling romance author, Sylvia Day."
    puts "Would you like to see a list of the books she has written? Please type 'yes' or 'no'."

    while true
      input = gets.chomp.downcase
      if input == "yes" || input == "y"
        choose_book
        break
      elsif input == "no" || input == "n"
        puts "Thank you for using Sylvia Day's library. Goodbye."
        break
      else
        puts "Invalid input. Please try again."
      end
    end
  end

  def choose_book
    DayBooks::Scraper.get_book_info
    books = DayBooks::Scraper.books_array
    books.each {|book| DayBooks::Book.create(book[:title], book[:book_url])}
    DayBooks::Book.all.sort_by! {|book| book.title}
    DayBooks::Book.all.each {|book| puts "#{book.title}"}

    puts "Please type the title of the book you'd like to learn more about!"
    while true
      chosen_book = gets.chomp.downcase
      if DayBooks::Book.downcase_all_titles.include?(chosen_book)
        return_description(chosen_book)
        start_over?
        break
      else
        puts "Invalid input. Please try again."
      end
    end
  end

  def return_description(chosen_book)
    book_url = ""
    DayBooks::Book.all.each do |book|
      if book.title.downcase == chosen_book
        book_url = book.book_url
      end
    end
    description = DayBooks::Scraper.get_description(book_url)
    if description == ""
      puts "Sorry this book has no description."
    else
      puts description
    end
  end

  def start_over?
    puts "Would you like to see the list of books again? Please type 'yes' or 'no'."
    while true
      input = gets.chomp.downcase
      if input == "yes" || input == "y"
        DayBooks::Scraper.empty_books_array
        DayBooks::Book.empty_all
        choose_book
        break
      elsif input == "no" || input == "n"
        puts "Thank you for using Sylvia Day's library. Goodbye."
        break
      else
        puts "Invalid input. Please try again."
      end
    end
  end
end