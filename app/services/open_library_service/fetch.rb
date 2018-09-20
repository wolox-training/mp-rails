require 'httparty'
require_relative 'open_library_service_errors/book_info_fetch_error'
module OpenLibraryService
  class Fetch
    class_attribute :http_client
    include HTTParty
    include OpenLibraryServiceErrors
    base_uri 'https://openlibrary.org/api'
    def self.book_info(isbn)
      @options = { query: { format: 'json', jscmd: 'data' } }
      @options[:query][:bibkeys] = "ISBN:#{isbn}"
      response = get('/books', @options)
      return response if response.code == 200
      raise BookInfoFetchError, response: { http_code: response.code }
    end
  end
end
