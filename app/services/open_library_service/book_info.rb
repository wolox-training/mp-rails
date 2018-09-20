module OpenLibraryService
  module BookInfo
    @book_details = {}
    def self.create_hash(book)
      book.each do |key, obj|
        @book_details = {
          isbn: key.split('ISBN:')[1],
          title: obj['title'],
          subtitle: obj['subtitle'],
          number_of_pages: obj['number_of_pages'],
          authors: get_authors_array(obj['authors'])
        }
      end
      @book_details
    end

    def self.get_authors_array(authors)
      authors.map { |author| author['name'] }
    end
  end
end
