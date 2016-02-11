class Currencies

	def initialize(amt)
		@amt = (amt * 100)
	end

  def to_i
  	@amt.to_i
  end

	def ratio
		1
	end

 	def ==(other)
		a = Bank.new.pennies_to_dollars(@amt)
		b = Bank.new.pennies_to_dollars(other.to_i)
	  (@amt.to_i / self.ratio) == (other.to_i / other.ratio)
	end

  def plus(other)
		if other.kind_of? Currencies
			x = (self.to_i / self.ratio) + (other.to_i / other.ratio)
			Currencies.new(x / 100)
	  else
			other *= 100
			self.class.new((@amt + other) / 100 )
  	end
  end

  def minus(other)
		if other.kind_of? Currencies
  		Currencies.new(((self.to_i / self.ratio) - (other.to_i / other.ratio)) / 100)
    else
			self.class.new((@amt - (other * 100)) / 100)
		end
  end

  def times(multiplier)
  	if multiplier.kind_of? Currencies
  	  Currencies.new((self.to_i / self.ratio) * (multiplier.to_i / multiplier.ratio) / 10000)
  	else
			self.class.new((@amt * multiplier) / 100)
		end
  end

  def dividedby(divisor)
  	if divisor.kind_of? Currencies
  	  Currencies.new((self.to_i / self.ratio) / (divisor.to_i / divisor.ratio))
    else
			self.class.new(@amt / (divisor * 100))
		end
  end

end

class USADollars < Currencies
	def abbreviation
		"$"
	end

	def ratio
		1
	end
end

class SwissFrancs < Currencies
	def abbreviation
		"CHF"
	end

	def ratio
		2
	end
end

class Dinar < Currencies
	def abbreviation
		"JOD"
	end

	def ratio
		0.709
	end
end

class Bank

	def convert_to_base(amount)
		amount.to_i * amount.ratio
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
