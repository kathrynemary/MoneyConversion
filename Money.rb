class USADollars

	def initialize(amt)
		@amt = amt
	end

	def ==(other)
		@amt == other
	end


	def times(multiplier)
		x = USADollars.new(@amt * multiplier)
    end

end

