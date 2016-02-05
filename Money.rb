class Currencies

	def initialize(amt)
		@amt = amt
	end

    def to_i
    	@amt.to_i
    end

    def times(multiplier)
    	self.class.new(@amt * multiplier)
    end

    def plus(other)
    	# converted = Bank.new.convert_to(other, self.class)
        if abbreviation == other.abbreviation
    	    self.class.new(@amt + other.to_i)
    	elsif abbreviation == "$" && other.abbreviation == "CHF"
			self.class.new(Bank.new.dollars_to_francs(@amt)).plus(other.to_i)
		elsif abbreviation == "CHF" && other.abbreviation == "$"
			Bank.new.francs_to_dollars(@amt) + other.to_i
		end
    end

	def ==(other)
		if abbreviation == other.abbreviation
			@amt == other.to_i
		elsif abbreviation == "$" && other.abbreviation == "CHF"
			Bank.new.dollars_to_francs(@amt) == other.to_i
		elsif abbreviation == "CHF" && other.abbreviation == "$"
			Bank.new.francs_to_dollars(@amt) == other.to_i
		end
	end


end

class USADollars < Currencies
	def abbreviation
		"$"
	end

end

class SwissFrancs < Currencies
	def abbreviation
		"CHF"
	end

end


class Bank

	def dollars_to_francs(x)
		2 * x
	end

	def francs_to_dollars(x)
		x / 2
	end

end




