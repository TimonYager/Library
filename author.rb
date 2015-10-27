class Author
	attr_accessor :name, :biography

	def initialize(name, biography = nil)
		@name, @biography = name, biography
	end

	def ==(author)
		self.name == author.name
	end

	def to_s
		"#{@name}. #{@biography}"
	end
end

