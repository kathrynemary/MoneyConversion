require 'minitest/autorun'
require './Money'

class Money < Minitest::Test
 	def test_five_dollars_is_not_six_dollars
		x = USADollars.new(5)
		y = USADollars.new(6)
		refute_equal y, x
	end

	def test_five_dollars_is_five_dollars
		x = USADollars.new(5)
		y = USADollars.new(5)
		assert_equal x, y
	end

	def test_five_times_two_is_ten
		x = USADollars.new(5)
		y = USADollars.new(10)
		assert_equal x.times(2), y
	end

	def test_five_times_three_is_fifteen
		x = USADollars.new(5).times(3)
		y = USADollars.new(15)
		assert_equal x, y
	end

	def test_five_francs_is_five_francs
		x = SwissFrancs.new(5)
		y = SwissFrancs.new(5)
		assert_equal x, y
	end

	def test_five_times_two_is_ten_francs
		x = SwissFrancs.new(5).times(2)
		y = SwissFrancs.new(10)
		assert_equal x, y
	end

	def test_four_francs_is_not_four_dollars
		x = USADollars.new(4)
		y = SwissFrancs.new(4)
		refute_equal x, y
	end

	def test_dollars_are_currency
		x = USADollars.new(3)
		assert_kind_of Currencies, x
	end

	def test_francs_are_currency
		x = SwissFrancs.new(3)
		assert_kind_of Currencies, x
	end

	def test_ten_francs_is_five_dollars
		x = USADollars.new(5)
		y = SwissFrancs.new(10)
		assert_equal x, y
	end

	def test_five_dollars_is_ten_francs
		x = USADollars.new(5)
		y = SwissFrancs.new(10)
		assert_equal y, x
	end

	def test_five_plus_five_dollars_is_ten
		x = USADollars.new(5)
		y = USADollars.new(10)
		assert_equal x.plus(x), y
	end

	def test_five_plus_five_francs_is_ten
		x = SwissFrancs.new(5)
		y = SwissFrancs.new(10)
		assert_equal x.plus(x), y
	end

	def test_five_dollars_plus_ten_francs_is_ten_dollars
		x = USADollars.new(5)
		y = SwissFrancs.new(10)
		z = USADollars.new(10)
		assert_equal x.plus(y), z
	end

	def test_ten_francs_plus_five_dollars_is_twenty_francs
		x = USADollars.new(5)
		y = SwissFrancs.new(10)
		z = SwissFrancs.new(20)
		assert_equal y.plus(x), z
	end

	def test_2_dollars_times_4_francs_is_4_dollars
		x = USADollars.new(2)
		y = SwissFrancs.new(4)
		z = USADollars.new(4)
		assert_equal x.times(y), z
	end

end

class Banking < Minitest::Test

	def test_output_is_in_francs
		x = Bank.new.dollars_to_francs(5)
		y = SwissFrancs.new(10)
		assert_equal x, y
	end

	#is it bad that the functionality of Bank is being tested w/i Money?

end



#Tests to pass, in general:
#money rounding?
#hashCode (??)
#equal null
#equal object (??)
#common times
#compare francs with dollars (??)
#refactor "times" methods
#$5 + 10francs is $10
#make it work with noninteger dollars
#add them together, divide, subtract, multiply

#test bank, build it out to be better
#then go back to the other methods


