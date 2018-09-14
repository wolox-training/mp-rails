module OpenLibraryService
  module OpenLibraryServiceErrors
    class BookNotFoundError < StandardError
      def message
        'Nothing found'
      end
    end
  end
end
