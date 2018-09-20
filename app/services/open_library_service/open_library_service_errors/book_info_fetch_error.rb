module OpenLibraryService
  module OpenLibraryServiceErrors
    class BookInfoFetchError < StandardError
      def initialize(data)
        @data = data
      end

      def message
        'Error fetching book info from OpenLibrary.'
      end
    end
  end
end
