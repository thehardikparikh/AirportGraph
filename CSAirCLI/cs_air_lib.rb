require '../JSONParseTool/json_to_graph'


class CSAirLib

  # basic constructor for a CsAirLib object
  def initialize

    @query = JSONToGraph.new
    @largest_integer = 4611686018427387903 #largest possible value of integer

  end

  # method to print the list of cities that CSAir flies to
  def print_city_list

    # simply call the print_vertices function of the graph API
    @query.get_graph.each_key { |city| puts "#{get_city_info(city,"name")}"}

  end

  # method to get a particular aspect of data about a city
  # @param [String] city - code of the city in question
  # @param [String] infoKey - particular information that we want about the city
  def get_city_info(city, infoKey)

    info_dict = @query.json_graph_api.get_vertex_data(city)
    return info_dict[infoKey]

  end


  # method to get a list of all the cities accessible via this city in a single flight
  # and the distance of each of those flights
  # @param [String] city code of the city in question
  # @return [Hash] a hash of destinations (key) and flight distance (value)
  def get_outgoing_routes(city)

    route_dict = {}

    # edges_dict will be a Hash of destinations (keys) and route data (values)
    edges_dict = @query.json_graph_api.get_outgoing_edges(city)
    edges_dict.each { |dest, data| route_dict.store(get_city_info(dest,"name"), data["distance"]) }

    return route_dict

  end

  # method to get the longest single flight in the network
  # @return [String] a string denoting the longest flight in the network
  def longest_single_flight

    max_distance = -1
    flight = ""
    @query.get_graph.each_key do |city|
      route_dict = get_outgoing_routes(city)
      route_dict.each do |dest, dist|
        if dist > max_distance
          max_distance = dist
          flight = "#{get_city_info(city,"name")}-#{dest}"
        end
      end
    end

    return flight

  end

  # method to return the shortest single flight in the network
  # @return [String] a string denoting the shortest single flight
  def shortest_single_flight

    min_distance = @largest_integer
    flight = ""
    @query.get_graph.each_key do |city|
      route_dict = get_outgoing_routes(city)
      route_dict.each do |dest, dist|
        if dist < min_distance
          min_distance = dist
          flight = "#{get_city_info(city,"name")}-#{dest}"
        end
      end
    end

    return flight

  end

  # method to get the average flight length over all routes
  # @return [Integer] average flight lenght
  def average_flight_length

    sum = 0
    count = 0
    @query.get_graph.each_key do |city|
      route_dict = get_outgoing_routes(city)
      route_dict.each do |dest, dist|
        sum+=dist
        count+=1
      end
    end

    return sum/count

  end

  # method to get the city with the biggest population
  # @return [String] city with the biggest population
  def biggest_population_city

    max_population = -1
    max_city = ""

    @query.get_graph.each_key do |city|
      population = get_city_info(city,"population")
      if population > max_population
        max_population = population
        max_city = "#{get_city_info(city,"name")}"
      end
    end

    return max_city
  end

  # method to get the city with the smallest population
  # @return [String] city with the smallest population
  def smallest_population_city

    min_population = @largest_integer
    min_city = ""
    @query.get_graph.each_key do |city|
      population = get_city_info(city,"population")
      if population < min_population
        min_population = population
        min_city = "#{get_city_info(city,"name")}"
      end
    end

    return min_city

  end

  # method to return the average population of the network
  # @return [Integer] the average population of the network
  def average_population

    sum = 0
    count = 0

    @query.get_graph.each_key do |city|
      population = get_city_info(city,"population")
      sum+=population
      count+=1
    end

    return sum/count

  end

  # method to get the list of continents travelled to by CSAir network and the
  # list of cities in those continents
  # @return [Hash] hash map with continent as key and list of cities as value
  def list_of_continents

    hash_continents = {}
    @query.get_graph.each_key do |city|
      continent = get_city_info(city, "continent")
      if not hash_continents.has_key?(continent)
        hash_continents[continent] = []
      end
      hash_continents[continent] << get_city_info(city,"name")
    end

    return hash_continents

  end

  # helper method for list of hub cities. Returns the maximum number of incoming nodes
  # @return [Integer] maximum count of incoming nodes
  def max_incoming_flights

    max_count = -1
    @query.get_graph.each_key do |city|
      count = @query.json_graph_api.count_incoming_edges(city)
      if count > max_count
        max_count = count
      end
    end
    return max_count

  end

  # returns the list of cities which have the most direct connections
  # @return [Array] list of hubs
  def list_of_hubs

    hub_list = []
    max_count = self.max_incoming_flights

    #if the count of incoming edges is == max count then add to list
    @query.get_graph.each_key do |city|
      count = @query.json_graph_api.count_incoming_edges(city)
      if count == max_count
        hub_list.push("#{get_city_info(city,"name")}")
      end
    end

    return hub_list

  end

  attr_accessor :query
end

