require_relative '../lib/day_books/version.rb'

class DayBooks::CLI
  def call
    puts "
           .--.            .---.
       .---|__|    .-.     |~~~|
    .--| S |--|    |_|     |~~~|--.
    |  | Y |  |.---!~|  .--| B |--|
    |  | L |  ||===| |--|  | O |  |
    |  | V |  || D | |__|  | O |  |
    |  | I |  || A | |==|  | K |  |
    |  | A |__|| Y |_|__|  | S |__|
    |  |===|--||===|~|--|  |~~~|--|
    '--'---'--''---'-'--'--'---'--' "
    puts "Welcome to the book library of best selling romance author, Sylvia Day."
    puts "Would you like to see a list of the books she has written? Please type 'yes' or 'no'."

    DayBooks::Scraper.get_book_info
    DayBooks::Scraper.books_array.each {|book| DayBooks::Book.create(book[:title], book[:book_url])}

    while true
      input = gets.chomp.downcase
      if input == "yes" || input == "y"
        choose_book
        break;
      elsif input == "no" || input == "n"
        puts "Thank you for using Sylvia Day's library. Goodbye."
        break;
      else
        puts "Invalid input. Please try again."
      end
    end
  end

  def choose_book
    DayBooks::Book.all.sort_by! {|book| book.title}
    DayBooks::Book.all.each_with_index {|book, index| puts "#{index + 1}. #{book.title}"}

    puts "Please type the number of the book you'd like to learn more about!"

    while true
      input = gets.chomp.to_i - 1
      if input < DayBooks::Book.all.count
        return_description(DayBooks::Book.all.fetch(input).title)
        break;
      else
        puts "Invalid input. Please try again."
      end
    end
  end

  def return_description(chosen_book)
    book_url = DayBooks::Book.all.select {|book| book.title == chosen_book}.first.book_url

    description = DayBooks::Scraper.get_description(book_url)
    puts description.empty? ? "Sorry this book has no description" : description

    start_over?
  end

  def start_over?
    puts "Would you like to see the list of books again? Please type 'yes' or 'no'."
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
end
