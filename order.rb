class Order
	attr_accessor :book, :reader
	attr_reader :date

	def initialize(book, reader)
		@book, @reader = book, reader
		@date = Time.now
	end

	def to_s
		"Order on #{@date.strftime("%D, %R")}, '#{@book.title}', ordered by #{@reader.name}"
	end
end