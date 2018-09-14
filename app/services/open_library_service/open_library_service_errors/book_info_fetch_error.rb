module OpenLibraryService
  module OpenLibraryServiceErrors
    class BookInfoFetchError < StandardError
      def initialize(data)
        @data = data
      end

      def message
        { error: 'Error fetching book info from OpenLibrary.', details: @data }
      end
    end
  end
end
