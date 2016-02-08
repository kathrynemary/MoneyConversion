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


class Bank

    def convert_money(amt, second)
    	if amt.abbreviation == "CHF" && second.abbreviation == "$"
    		x = dollars_to_francs(second)
    		#puts "I now have #{x} francs instead of #{amt} dollars."
    		USADollars.new(x)
    	elsif amt.abbreviation == "$" && second.abbreviation == "CHF"
    		x = francs_to_dollars(second)
    		#puts "I now have #{x} dollars instead of #{amt} francs."
    		SwissFrancs.new(x)
    	end
    end

	def dollars_to_francs(x)
		2 * x.to_i
	end

	def francs_to_dollars(x)
		#puts "I start with #{x.to_i} and then I get #{x.to_i / 2}"
		(x.to_i / 2)

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




