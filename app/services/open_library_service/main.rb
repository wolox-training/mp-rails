require_relative 'open_library_service_errors/invalid_isbn'
require_relative 'valid_isbn'
require_relative 'fetch'
require_relative 'book_info'
module OpenLibraryService
  include OpenLibraryServiceErrors
  include ValidIsbn
  include BookInfo
  module Main
    def self.book_info(isbn)
      raise  OpenLibraryServiceErrors::InvalidISBN unless ValidIsbn.valid_isbn?(isbn)
      book = Fetch.book_info(isbn)
      BookInfo.create_hash(book)
    end
  end
end
