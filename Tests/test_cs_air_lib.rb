require 'test/unit'
require '../CSAirCLI/cs_air_lib'

class TestCSAirLib < Test::Unit::TestCase

  # testing Washington's name, population, country, continent
  def test_get_city_info
    lib = CSAirLib.new
    assert_equal(lib.get_city_info('WAS','name'),'Washington')
    assert_equal(lib.get_city_info('WAS','country'),'US')
    assert_equal(lib.get_city_info('WAS','continent'),'North America')
    assert_equal(lib.get_city_info('WAS','timezone'),-5)
    assert_equal(lib.get_city_info('WAS','coordinates'),{"N"=>39, "W"=>77})
    assert_equal(lib.get_city_info('WAS','population'),8250000)
  end

  # check longest single flight
  def test_longest_single_flight
    lib = CSAirLib.new
    assert_equal(lib.longest_single_flight,'Sydney-Los Angeles')
  end

  # check shortest single flight
  def test_shortest_single_flight
    lib = CSAirLib.new
    assert_equal(lib.shortest_single_flight,'Washington-New York')
  end

  # check average flight length
  def test_average_flight_length
    lib = CSAirLib.new
    assert_equal(lib.average_flight_length,2300)
  end

  # check biggest population city
  def test_biggest_population_city
    lib = CSAirLib.new
    assert_equal(lib.biggest_population_city,'Tokyo')
  end

  # check smallest population city
  def test_smallest_population_city
    lib = CSAirLib.new
    assert_equal(lib.smallest_population_city,'Essen')
  end

  # check average population
  def test_average_population
    lib = CSAirLib.new
    assert_equal(lib.average_population,11796143)
  end

end