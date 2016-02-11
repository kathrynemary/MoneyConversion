class Currencies

	def initialize(amt)
		@amt = (amt * 100)
	end

    def to_i
    	@amt.to_i
    end

   	def ==(other)

   		a = Bank.new.pennies_to_dollars(@amt)
   		b = Bank.new.pennies_to_dollars(other.to_i)

		if abbreviation == other.abbreviation
			@amt == other.to_i
		elsif abbreviation == "$" && other.abbreviation == "CHF"
			(@amt * 2) == other.to_i
		elsif abbreviation == "CHF" && other.abbreviation == "$"
			(@amt / 2) == other.to_i
		elsif abbreviation == "JOD"
			if other.abbreviation == "$"
			  (other.to_i * 0.709) == @amt
			elsif other.abbreviation == "CHF"
				((other.to_i * 0.709) / 2) == @amt
			end
		end


	end

    def plus(other)
        if other.class == Fixnum || other.class == Float
        	other *= 100
    		self.class.new((@amt + other) / 100 )
        elsif abbreviation == other.abbreviation
    	    self.class.new((@amt + other.to_i) / 100)
    	else
    		x = Bank.new.convert_money(self, other)
    		y = x.to_i / 100
    		self.class.new((@amt + y) / 100)
    	end
    end

    def minus(other)
        if other.class == Fixnum || other.class == Float
        	other *= 100
        	self.class.new((@amt - other) / 100)
        elsif abbreviation == other.abbreviation
    	    self.class.new(@amt - other.to_i)
    	else
    		x = Bank.new.convert_money(self, other)
    		y = x.to_i / 100
    		self.class.new((@amt - y) / 100)
    	end
    end

    def times(multiplier)
    	if multiplier.class == Fixnum || multiplier.class == Float
    		x = multiplier * 100
    		self.class.new((@amt * x) / 10000)
    	elsif abbreviation == multiplier.abbreviation
    	    self.class.new(@amt * multiplier.to_i)
    	else
    		x = Bank.new.convert_money(self, multiplier)
    	    self.class.new((@amt * x.to_i) / 1000000)
    	end
    end

    def dividedby(divisor)
    	if divisor.class == Fixnum || divisor.class == Float
    		divisor *= 100
    		self.class.new(@amt / divisor)
    	elsif abbreviation == divisor.abbreviation
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

class Dinar < Currencies
	def abbreviation
		"JOD"
	end
end

class Bank

    def convert_money(amt, second) #make this betterrrrr
    	if amt.abbreviation == "JOD"
				if second.abbreviation == "$"
			  	dollars_to_dinars(amt)
			  elsif second.abbreviation == "CHF"
          francs_to_dollars(second)
					dollars_to_dinars(second)
				end
			elsif amt.abbreviation == "CHF" && second.abbreviation == "$"
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
		z = USADollars.new(y)
		return z
	end

	def dollars_to_dinars(x)
		y = x * 0.709
		Dinar.new(y)

	end


	def pennies_to_dollars(amt)
		x = amt.to_s
        if x.include?(".")
        	x.sub!(/\.\d*/, '')
        end

        if x == "0"
        	return x
        else
            x.insert(-3, ".")
        end

    end

end
