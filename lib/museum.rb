class Museum

	attr_reader :name, :exhibits, :patrons

	def initialize(name)
		@name = name
		@exhibits = []
		@patrons = []
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

	def admit(patron)
		@patrons << patron
	end

	def patrons_by_exhibit_interest
		hash_of_interests = {}
		@exhibits.each do |exhibit|
			hash_of_interests[exhibit] = []
		end

		@patrons.each do |patron|
			recommend_exhibits(patron).each do |exhibit|
				hash_of_interests[exhibit] << patron
			end
		end
		hash_of_interests
	end

	def ticket_lottery_contestants(exhibit)
		patrons_by_exhibit_interest[exhibit].find_all do |patron|
			patron.spending_money < exhibit.cost
		end
	end

	def draw_lottery_winner(exhibit)
		winner = ticket_lottery_contestants(exhibit).sample

		if @patrons.include?(winner)
			winner.name
		else
			nil
		end

	end

	def announce_lottery_winner(exhibit)
		winner = draw_lottery_winner(exhibit)
		if winner != nil
			p "#{winner} has won the #{exhibit} exhibit lottery"
		else
			p "No winners for this lottery"
		end
	end
end