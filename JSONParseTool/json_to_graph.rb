require 'json'
require 'open-uri'
require '../Graph/graph_api'
class JSONToGraph

  # method to initialize the JSONtoGraph object
  # JSONtoGraph contains the following attributes
  # json_url - the url to be used for receiving the JSON data for cities and routes
  # json_dict  - the dict made by parsing the JSON data
  # json_graph_api - the graph populated using the JSON data
  # city_to_code  - a hash mapping each city to its corresponding code
  def initialize

    @json_url = 'https://wiki.cites.illinois.edu/wiki/download/attachments/502596813/map_data.json?version=1&modificationDate=1408551729000&api=v2'
    @json_dict = JSON.parse open(@json_url).read
    @json_graph_api = GraphAPI.new
    @city_to_code = {}
    parse_and_add_cities
    parse_and_add_routes

  end

  # method to parse cities from the json_dict and populate the graph with vertices (cities)
  # also populates the city_to_code hash
  def parse_and_add_cities

    cities_list = @json_dict['metros'] 
    cities_list.each do |city_dict|
      @json_graph_api.add_vertex(city_dict['code'],city_dict)
      @city_to_code[city_dict['name']] = city_dict['code']
    end

  end

  # method to parse routes and populate the graph with edges
  def parse_and_add_routes

    routes_list = @json_dict['routes']

    routes_list.each do |route|
      source = route['ports'][0]
      destination = route['ports'][1]
      @json_graph_api.add_edge(source,destination,route)
    end

  end

  # getter for the actual underlying graph
  # @return [Hash] the actual underlying graph
  def get_graph
    
    return json_graph_api.graph
    
  end
  
  # method to get the url needed to map on www.gcmap.com
  # @return [String] the mapping url
  def get_map_url
    
    start_url = 'http://www.gcmap.com/mapui?P='
    set_edges = @json_graph_api.list_edges
    list_edges = []
    set_edges.each {|edge| list_edges.push(edge)}
    start_url += list_edges.join(',+')
    return start_url
    
  end
  
  attr_accessor :json_graph_api
  attr_accessor :city_to_code
end

