class Reader
	attr_accessor :name, :email, :city, :street, :house

	def initialize(name, email = nil, city = nil, street = nil, house = nil)
		@name, @email = name, email
		@city, @street, @house = city, street, house
	end

	def ==(reader)
		self.name == reader.name
	end

	def address
		"#{@city} city, #{@street} street, №#{house}"
	end

	def to_s
		"#{@name}, #{address}"
	end
end