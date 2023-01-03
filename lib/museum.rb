class Museum

	attr_reader :name, :exhibits

	def initialize(name)
		@name = name
		@exhibits = []
	end

	def add_exhibit(exhibit)
		@exhibits << exhibit
	end

	def recommend_exhibits(patron)
		@recommended = []
		patron.interests.each do |interest|
			find_interest(interest)
		end
		@recommended
	end

	def find_interest(interest)
		@exhibits.find do |exhibit|
			if exhibit.name == interest
				@recommended << exhibit
			end
		end
	end
end