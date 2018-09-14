# ^(?:ISBN(?:-1[03])?:?●)?(?=[-0-9●]{17}$|[-0-9X●]{13}$|[0-9X]{10}$)↵
# (?:97[89][-●]?)?[0-9]{1,5}[-●]?(?:[0-9]+[-●]?){2}[0-9X]$
require 'library_stdnums'
module OpenLibraryService
  module ValidIsbn
    include StdNum

    def self.valid_isbn?(isbn)
      # pattern = Regexp.new('^(?:ISBN(?:-1[03])?:?●)?(?=[-0-9●]{17}$|[-0-9X●]{13}$|[0-9X]{10}$)↵
      # (?:97[89][-●]?)?[0-9]{1,5}[-●]?(?:[0-9]+[-●]?){2}[0-9X]$')
      # #pattern.match?(isbn)

      ISBN.valid?(isbn)
    end
  end
end
