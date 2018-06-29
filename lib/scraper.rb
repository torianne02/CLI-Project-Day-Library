require 'nokogiri'
require 'open-uri'

class DayBooks::Scraper
  @@books_array = []

  def self.books_array
    @@books_array
  end

  def self.empty_books_array
    @@books_array.clear
  end

  def self.get_page(page_url)
    Nokogiri::HTML(open(page_url))
  end

  def self.get_book_info
    author_library_url = "https://www.goodreads.com/author/list/19823.Sylvia_Day?page=1&per_page=99999"
    book_info = self.get_page(author_library_url).css('tr[itemtype="http://schema.org/Book"]')
    book_info.each do |book|
      @@books_array << {
        :title => book.css('.bookTitle span[itemprop=name]').text,
        :book_url => book.css('a').attribute('href').value
      }
    end
  end

  def self.get_description(book_url)
    full_book_url = "https://www.goodreads.com" + book_url
    doc = self.get_page(full_book_url)
    book_description = doc.css('div#descriptionContainer span[2]').text
    book_description
  end
end
