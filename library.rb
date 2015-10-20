class Library
	attr_accessor :books, :authors, :readers, :orders

	def initialize(books = nil, authors = nil, readers = nil, orders = nil)
		@books   = books
		@authors = authors
		@readers = readers
		@orders  = orders
		puts status
	end

	def status
		"Library has #{@books.size} books, #{@authors.size} authors, #{@readers.size} readers and #{@orders.size} orders."
	end

	def add_book(title, author_name)
		unless @books.include?(Book.new(title, author_name))
			if @authors.include?(Author.new(author_name))
				@books << Book.new(title, @authors.find { |author| author.name == author_name })
			else
				@authors << Author.new(author_name)
				@books << Book.new(title, @authors.last)
			end
		end
	end

	def add_author(name, biography = nil)
		@authors << Author.new(name, biography) unless @authors.include?(Author.new(name))
	end

	def add_reader(name, email = nil, address = {})
		@readers << Reader.new(name, email, address) unless @readers.include?(Reader.new(name))
	end

	def add_order(book_title, reader_name)
		book   = @books.find   { |b| b.title == book_title }
		reader = @readers.find { |r| r.name == reader_name }
		@orders << Order.new(book, reader)
	end

	def delete_book(title, author_name)
		@books.delete_if { |book| book.title == title && book.author.name == author_name }
		puts "Book '#{title}' was successfully deleted."
	end

	def delete_author(name)
		@books.delete_if { |book| book.author.name == name }
		@authors.delete_if { |author| author.name == name }	
		puts "Author #{name} was successfully deleted with all his books."
	end

	def delete_order(book_title, reader_name)
		@orders.delete_if { |order| order.book.title == book_title && order.reader.name == reader.name }
		puts "Order on '#{book_title}' by #{reader_name} was successfully deleted."
	end

	def delete_reader(name)
		@orders.delete_if { |order| order.reader.name == name }
		@readers.delete_if { |reader| reader.name == name }
		puts "Reader #{name} was successfully deleted with all his orders."
	end

	def get_books(filename)
		f = File.open(filename.chomp)
		rescue Exception => e
			"File '#{filename}' doesn't exist."
		else
			f.each do |line|
				array = line.split(",").map(&:strip)
				add_book(array[0], array[1])
			end
			puts "Books (with authors) were taken from '#{filename}'"
		ensure
			f.close
			puts status
	end

	def get_authors(filename)
		f = File.open(filename.chomp)
		rescue Exception => e
			"File '#{filename}' doesn't exist."
		else
			f.each do |line|
				array = line.split(",").map(&:strip)
				add_author(array[0], array[1])
			end
			puts "Authors were taken from '#{filename}'"
		ensure
			f.close
			puts status
	end

	def save_data(filename)
		f = File.open(filename.chomp, 'w')
		@books.each { |book| f.puts "#{book.title}, #{book.author.name}" }
		f.close
		puts "Books and authors were saved to '#{filename}'"
	end

	def most_popular_book
		max_key = @orders.each_with_object(h = Hash.new(0)) { |order, hash| hash[order.book.title] += 1 }.values.max
		h.key(max_key)
	end

	def people_ordered_one_of_three_most_popular_books
		popular_books = []
		readers = []
		hash = @orders.each_with_object(Hash.new(0)) { |order, hash| hash[order.book.title] += 1 }
		hash.sort_by { |key, value| value }.last(3).each_with_index { |elem, i| popular_books[i] = elem[0] }
		@orders.each { |order| readers << order.reader.name if popular_books.include?(order.book.title) }
		readers.uniq.size
	end

	def most_often_takes_books
		max_key = @orders.each_with_object(h = Hash.new(0)) { |order, hash| hash[order.reader.name] += 1 }.values.max
		h.key(max_key)
	end
end
