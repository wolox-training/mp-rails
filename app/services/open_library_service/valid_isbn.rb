require 'library_stdnums'
module OpenLibraryService
  module ValidIsbn
    include StdNum

    def self.valid_isbn?(isbn)
      ISBN.valid?(isbn)
    end
  end
end
