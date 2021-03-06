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

	def test_five_fifty_is_not_five
		x = USADollars.new(5.5)
		y = USADollars.new(5)
		refute_equal x, y
	end

	def test_coin_amounts_work
		x = SwissFrancs.new(0.63)
		y = SwissFrancs.new(0.63)
		assert_equal x, y
	end

	def test_adding_coin_amounts
		x = USADollars.new(0.17)
		y = USADollars.new(0.32)
		assert_equal x.plus(0.15), y
	end

	def test_adding_coin_to_whole_dollar
		x = USADollars.new(7)
		y = USADollars.new(7.50)
		assert_equal x.plus(0.50), y
	end

	def test_five_times_two_is_ten
		x = USADollars.new(5)
		y = USADollars.new(10)
		assert_equal x.times(2), y
	end

  def test_one_dinar_times_two_is_two
    x = Dinar.new(1)
    y = Dinar.new(2)
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

	def test_dollars_are_currency
		x = USADollars.new(3)
		assert_kind_of Currencies, x
	end

	def test_francs_are_currency
		x = SwissFrancs.new(3)
		assert_kind_of Currencies, x
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

	def test_five_plus_five_riyals_is_ten
		x = Riyals.new(5)
		y = Riyals.new(10)
		assert_equal x.plus(x), y
	end

	def test_4_riyals_plus_3
		x = Riyals.new(4)
		y = Riyals.new(7)
		assert_equal x.plus(3), y
	end

	def test_four_dollars_divided_by_two_is_two_dollars
		x = USADollars.new(4)
		y = USADollars.new(2)
		assert_equal x.dividedby(2), y
	end

	def test_multiple_operations_work
		x = SwissFrancs.new(10)
		y = SwissFrancs.new(16)
		assert_equal x.dividedby(2).plus(3), y.minus(8)
	end

	def test_five_pounds_minus_one
		x = Pounds.new(5)
		y = Pounds.new(4)
		assert_equal x.minus(1), y
  end

end

class Banking < Minitest::Test

  def test_dinars_convert_to_dollars
    x = USADollars.new(10)
    y = Dinar.new(7.09)
    assert_equal y, x
  end

  def test_francs_convert_to_dinars
    x = SwissFrancs.new(20)
    y = Dinar.new(7.09)
    assert_equal x, y
  end

  def test_dinars_convert_to_francs
    x = Dinar.new(7.09)
    y = SwissFrancs.new(20)
    assert_equal x, y
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

	def test_four_francs_is_not_four_dollars
		x = USADollars.new(4)
		y = SwissFrancs.new(4)
		refute_equal x, y
	end

	def test_four_dollars_divided_by_two_is_four_francs
		x = USADollars.new(4)
		y = SwissFrancs.new(4)
		assert_equal x.dividedby(2), y
	end

	def test_five_dollars_plus_ten_francs_is_ten_dollars
		x = USADollars.new(5)
		y = SwissFrancs.new(10)
		z = USADollars.new(10)
		assert_equal x.plus(y), z
	end

	def test_five_dollars_minus_ten_francs_is_zero_dollars
		x = USADollars.new(5)
		y = SwissFrancs.new(10)
		z = USADollars.new(0)
		assert_equal x.minus(y), z
	end

	def test_ten_francs_minus_five_dollars_is_zero_francs
		x = USADollars.new(5)
		y = SwissFrancs.new(10)
		z = SwissFrancs.new(0)
		assert_equal y.minus(x), z
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

	def test_multiple_operations_work
		x = SwissFrancs.new(10)
		y = USADollars.new(16)
		assert_equal x.dividedby(2).plus(3).times(4), y.minus(8).times(2)
	end

	def test_3_riyals_is_80_cents
    x = Riyals.new(3)
		y = USADollars.new(0.8)
		assert_equal x, y
	end

	def test_three_riyals_is_correct_francs
		x = Riyals.new(3)
		y = SwissFrancs.new(1.60)
		assert_equal x, y
	end

	def test_two_times_two_dollars_to_pounds
    x = USADollars.new(2)
		y = Pounds.new(6032)
		assert_equal x.times(2), y
	end
end
