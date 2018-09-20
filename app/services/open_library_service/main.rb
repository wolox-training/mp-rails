module OpenLibraryService
  module Main
    def self.book_info(isbn)
      raise  OpenLibraryServiceErrors::InvalidISBN unless ValidIsbn.valid_isbn?(isbn)
      book = Fetch.book_info(isbn)
      BookInfo.create_hash(book)
    end
  end
end
