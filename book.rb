class Book
	attr_accessor :title, :author
	
	def initialize(title, author)
		@title, @author = title, author
	end

	def ==(book)
		self.title == book.title && self.author == book.author
	end

	def to_s
		"'#{@title}', #{@author.name}"
	end
end