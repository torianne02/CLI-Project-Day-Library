require_relative '../config/environment.rb'

class DayLibrary
  attr_accessor :chosen_book

  def calls_library
    puts "Welcome to the book library of best selling romance author, Sylvia Day."
    puts "Would you like to see a list of the books she has written? Please type 'yes' or 'no'."

    input = gets.chomp
    if input.downcase == "yes" || input.downcase == "y"
      choose_book
    elsif input.downcase == "no" || input.downcase == "n"
      puts "Thank you for using Sylvia Day's library. Goodbye."
    else
      puts "Invalid input. Please try again."
    end
  end

  def choose_book
    books = Book.all.sort_by! {|book| book.title}
    puts "#{books}"
    books.each {|book| puts "#{book.title}"}

    puts "Please type the title of the book you'd like to learn more about!"
    input = gets.chomp
    if Book.all.include?(input)
      chosen_book = input
      return_description(chosen_book)
      start_over?
    else
      puts "Invalid input. Please try again."
    end
  end

  def return_description(book_title)
    Scraper.get_description(book_title)
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

a = DayLibrary.new
a.calls_library