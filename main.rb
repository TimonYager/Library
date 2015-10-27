require './library'
require './author'
require './book'
require './reader'
require './order'

authors = [
	keyes = Author.new("Daniel Keyes", "Famous writer and scientist."),
	poe = Author.new("Edgar Allan Poe", "Father of the horror and detective genres."),
	king = Author.new("Stephen King"),
	kafka = Author.new("Franz Kafka")
]

books = [
	algernon = Book.new("Flowers For Algernon", keyes),
	black_cat = Book.new("Black Cat", poe),
	raven = Book.new("Raven", poe),
	billy = Book.new("The Minds Of Billy Milligan", keyes),
	hearts = Book.new("Hearts In Atlantis", king),
	process = Book.new("Process", kafka),
	things = Book.new("Needful Things", king),
	castle = Book.new("Castle", kafka),
	green_mile = Book.new("Green Mile", king)
]

readers = [
	vincent = Reader.new("Vincent Vega", "pulp@mail.com", "Texas", "Elm", 144),
	jules = Reader.new("Jules Winnfield", "fiction@mail.com", "Minnesota", "Rotten", 12),
	ode_su = Reader.new("O De Su", "oldboy@mail.com", "Tokyo", "Fish", 1228),
	norman = Reader.new("Norman Bates", "psycho@mail.com", "New York", "Unknown", 1)
]

orders = [
	order1 = Order.new(algernon, vincent),
	order2 = Order.new(things, vincent),
	order3 = Order.new(black_cat, jules),
	order4 = Order.new(castle, ode_su),
	order5 = Order.new(billy, ode_su),
	order6 = Order.new(green_mile, vincent),
	order7 = Order.new(billy, norman),
	order8 = Order.new(raven, ode_su),
	order9 = Order.new(hearts, jules),
	order10 = Order.new(algernon, ode_su),
	order11 = Order.new(process, vincent),
	order12 = Order.new(billy, vincent),
	order13 = Order.new(raven, vincent)
]

library = Library.new(books, authors, readers, orders)

puts "The most popular book is '#{library.most_popular_book}'"
puts "#{library.people_ordered_one_of_three_most_popular_books} people ordered one of the three most popular books"
puts "Reader who the most often takes books is #{library.most_often_takes_books}"

library.get_books
library.get_authors
library.get_readers
library.get_orders

library.save_books
library.save_authors
library.save_readers
library.save_orders

library.delete_author(keyes)

