require 'minitest/autorun'
require './Money'

class Money < Minitest::Test
	def test_five_dollars_is_not_six_dollars
		x = USADollars.new(5)
		y = USADollars.new(6)
		diff y, x
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

end

