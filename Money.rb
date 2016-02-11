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
		elsif abbreviation == "$"
			if other.abbreviation == "CHF"
				(@amt * 2) == other.to_i
			elsif other.abbreviation == "JOD"
				(other.to_i / 0.709) == @amt
			end
		elsif abbreviation == "CHF"
			if other.abbreviation == "$"
			  (@amt / 2) == other.to_i
			elsif other.abbreviation == "JOD"
				(other.to_i / 0.709) * 2 == @amt
			end
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
			puts "#{self.to_i} #{x.abbreviation} plus #{x.to_i}"
			if abbreviation == other.abbreviation
			  self.plus(x)
			else
				puts "they still don't match"
				x = Bank.new.convert_money(self, x)

			end
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
  		self.class.new((@amt - x.to_i) / 10000)
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
  	  self.class.new((@amt * x.to_i) / 10000)
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

  def convert_money(amt, second)
		if amt.abbreviation == "$"
			puts "first amt is in dollars"
			convert_second_amt(amt, second)
		elsif amt.abbreviation == "JOD"
			dinars_to_dollars(amt)
		elsif amt.abbreviation == "CHF"
			francs_to_dollars(amt)
		end
	end

	def convert_second_amt(amt, second)
		if second.abbreviation == "CHF"
			francs_to_dollars(second)
		elsif second.abbreviation == "JOD"
			dinars_to_dollars(second)
		end
	end

	def francs_to_dollars(x)
		z = USADollars.new(x.to_i / 200)
		puts "i got #{z.to_i} #{z.abbreviation}."
		return z
	end

	def dinars_to_dollars(x)
		y = x / 0.709
		USADollars.new(y)
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
