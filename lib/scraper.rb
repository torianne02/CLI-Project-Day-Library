require 'nokogiri'
require 'open-uri'

class Scraper
  attr_accessor :books_array

  def initialize
    @books_array = []
  end

  def get_page(page_url)
    Nokogiri::HTML(open(page_url))
  end

  def get_book_info
    author_library_url = "https://www.goodreads.com/author/list/19823.Sylvia_Day?page=1&per_page=99999"
    book_info = self.get_page(author_library_url).css('tr[itemtype="http://schema.org/Book"]')
    book_info.each do |book|
      @books_array << {
        :title => book.css('.bookTitle span[itemprop=name]').text,
        :book_url => book.css('a').attribute('href').value
      }
    end
  end

  def get_description(title)
    full_book_url = ""
    @books_array.each do |book|
      if book.has_value?(title)
        full_book_url = ("https://www.goodreads.com" + book[:book_url])
      end
    end
    doc = self.get_page(full_book_url)
    book_description = doc.css('div#descriptionContainer span[2]').text
  end
end


a = Scraper.new
a.get_book_info
a.get_description("Entwined with You (Crossfire, #3)")