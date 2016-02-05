class Currencies

	def initialize(amt)
		@amt = amt
	end

    def to_i
    	@amt.to_i
    end

	def ==(other)
		if abbreviation == other.abbreviation
			@amt == other.to_i
		elsif abbreviation == "$" && other.abbreviation == "CHF"
		 	(@amt * 2) == other.to_i
		elsif abbreviation == "CHF" && other.abbreviation == "$"
			(@amt / 2) == other.to_i
		end
	end

end

class USADollars < Currencies

	def abbreviation
		"$"
	end

	def times(multiplier)
		x = USADollars.new(@amt * multiplier)
	end

end

class SwissFrancs < Currencies

	def abbreviation
		"CHF"
	end

	def times(multiplier)
		x = SwissFrancs.new(@amt * multiplier)
	end

end




