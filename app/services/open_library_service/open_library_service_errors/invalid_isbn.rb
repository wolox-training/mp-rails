module OpenLibraryService
  module OpenLibraryServiceErrors
    class InvalidISBN < StandardError
      def message
        'Invalid ISBN format.'
      end
    end
  end
end
