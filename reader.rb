class Reader
	attr_accessor :name, :email, :city, :street, :house

	def initialize(name, email = nil, address = {})
		@name, @email = name, email
		@city = address[:city]
		@street = address[:street]
		@house = Integer(address[:house])
	end

	def ==(name)
		self.name == name
	end

	def to_s
		@name
	end
end