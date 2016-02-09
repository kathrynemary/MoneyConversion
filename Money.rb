class Currencies

	def initialize(amt)
		if amt.class == Fixnum
		    @amt = amt
	    elsif amt.class == Float
	    	amt = pennies(amt)
	    	@amt = amt
	    	self.flag

	    end
	end

	def flag
		puts "I have flagged this test on #{@amt}."
		"Penny"
	end

	def pennies(number)
		number *= 100
	    number.to_i
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

		if self.flag
			puts "This amount is in pennies!"
		end
	end

    def plus(other)
        if other.class == Float
        	other *= 100
        	x = @amt + other.to_i
    		self.class.new(x / 100)
        elsif other.class == Fixnum || abbreviation == other.abbreviation
    	    self.class.new(@amt + other.to_i)
    	else
    		x = Bank.new.convert_money(self, other)
    		self.class.new(@amt + x.to_i)
    	end
    end

    def minus(other)
        if other.class == Fixnum || abbreviation == other.abbreviation
    	    self.class.new(@amt - other.to_i)
    	else
    		x = Bank.new.convert_money(self, other)
    		self.class.new(@amt - x.to_i)
    	end
    end

    def times(multiplier)
    	if multiplier.class == Fixnum || abbreviation == multiplier.abbreviation #this looks bad but i had my reasons! namely not wanting to create 2 multiplication methods.
    	    self.class.new(@amt * multiplier.to_i)
    	else
    		x = Bank.new.convert_money(self, multiplier)
    	    self.class.new(@amt * x.to_i)
    	end
    end

    def dividedby(divisor)
    	if divisor.class == Fixnum || abbreviation == divisor.abbreviation
    	    self.class.new(@amt / divisor.to_i)
    	else
    		x = Bank.new.convert_money(self, divisor)
    	    self.class.new(@amt / x.to_i)
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




