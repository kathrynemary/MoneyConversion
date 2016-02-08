class Currencies

	def initialize(amt)
		@amt = amt
	end

    def to_i
    	@amt.to_i
    end

    def times(multiplier)
    	if multiplier.class == Fixnum || abbreviation == multiplier.abbreviation #this looks bad but i had my reasons! namely not wanting to create 2 multiplication methods.
    	    self.class.new(@amt * multiplier.to_i)
    	else
    		x = Bank.new.convert_money(self, multiplier)
    	    self.class.new(@amt * x.to_i)
    	end
    end

    def plus(other)
        if abbreviation == other.abbreviation
    	    self.class.new(@amt + other.to_i)
    	else
    		x = Bank.new.convert_money(self, other)
    		self.class.new(@amt + x.to_i)
    	end
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
end

class SwissFrancs < Currencies
	def abbreviation
		"CHF"
	end
end

class Bank

    def convert_money(amt, second)
    	if amt.abbreviation == "CHF" && second.abbreviation == "$"
    		dollars_to_francs(second)
    	elsif amt.abbreviation == "$" && second.abbreviation == "CHF"
    		francs_to_dollars(second)
    	end
    end

	def dollars_to_francs(x)
		y = 2 * x.to_i
		SwissFrancs.new(y)
	end

	def francs_to_dollars(x)
		y = (x.to_i / 2)
		USADollars.new(y)
	end

end




