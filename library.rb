class Library
	attr_accessor :books, :authors, :readers, :orders

	def initialize(books = nil, authors = nil, readers = nil, orders = nil)
		@books   = books
		@authors = authors
		@readers = readers
		@orders  = orders
	end

	def add_book(book)
		@books << book unless @books.include?(book)
	end

	def add_author(author)
		@authors << author unless @authors.include?(author)
	end

	def add_reader(reader)
		@readers << reader unless @readers.include?(reader)
	end

	def add_order(order)
		@orders << order unless @orders.include?(order)
	end

	def delete_book(book)
		@books.delete(book)
	end

	def delete_author(author)
		@authors.delete(author)
	end

	def delete_order(order)
		@orders.delete(order)
	end

	def delete_reader(reader)
		@orders.delete(reader)
	end

	def get_books
		f = File.open("data/books")
		rescue IOError => e
			e.message
		else
			f.each do |line|
				args = line.split(",").map(&:strip)
				if author = @authors.find { |a| a.name == args[1] } 
					add_book(Book.new(args[0], author))
				else
					add_author(Author.new(args[1]))
					add_book(Book.new(args[0], @authors.last))
				end
			end
		ensure
			f.close
	end

	def get_authors
		f = File.open("data/authors")
		rescue IOError => e
			e.message
		else
			f.each do |line|
				args = line.split(",").map(&:strip)
				add_author(Author.new(args[0], args[1]))
			end
		ensure
			f.close
	end

	def get_readers
		f = File.open("data/readers") 
		rescue IOError => e
			e.message
		else
			f.each do |line|
				args = line.split(",").map(&:strip)
				add_reader(Reader.new(args[0], args[1], args[2], args[3], args[4]))
			end
		ensure
			f.close
	end

	def get_orders
		f = File.open("data/orders")
		rescue IOError => e
			e.message
		else
			f.each do |line|
				args = line.split(",").map(&:strip)
				if book = @books.find { |b| b.title == args[0] } && reader = @readers.find { |r| r.name == args[1] }
					add_order(Order.new(book, reader))
				end
			end
		ensure
			f.close
	end

	def save_books
		f = File.open("data/saved_data/books", 'w')
		@books.each { |book| f.puts book }
		f.close
	end

	def save_authors
		f = File.open("data/saved_data/authors", 'w')
		@authors.each { |author| f.puts author }
		f.close
	end

	def save_readers
		f = File.open("data/saved_data/readers", 'w')
		@readers.each { |reader| f.puts reader }
		f.close
	end

	def save_orders
		f = File.open("data/saved_data/orders", 'w')
		@orders.each { |order| f.puts order }
		f.close
	end


	def most_popular_book
		max_key = @orders.each_with_object(h = Hash.new(0)) { |order, hash| hash[order.book.title] += 1 }.values.max
		h.key(max_key)
	end

	def people_ordered_one_of_three_most_popular_books
		popular_books = []
		readers = []
		@orders.each_with_object(hash = Hash.new(0)) { |order, hash| hash[order.book.title] += 1 }
		hash.sort_by { |key, value| value }.last(3).each_with_index { |elem, i| popular_books[i] = elem[0] }
		@orders.each { |order| readers << order.reader.name if popular_books.include?(order.book.title) }
		readers.uniq.size
	end

	def most_often_takes_books
		max_key = @orders.each_with_object(h = Hash.new(0)) { |order, hash| hash[order.reader.name] += 1 }.values.max
		h.key(max_key)
	end
end
 
