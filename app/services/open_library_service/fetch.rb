module OpenLibraryService
  class Fetch
    class_attribute :http_client
    include HTTParty
    base_uri 'https://openlibrary.org/api'
    def self.book_info(isbn)
      @options = { query: { format: 'json', jscmd: 'data' } }
      @options[:query][:bibkeys] = "ISBN:#{isbn}"
      response = get('/books', @options)
      return response if response.code == 200
      raise OpenLibraryServiceErrors::BookInfoFetchError, response: {}
    end
  end
end
