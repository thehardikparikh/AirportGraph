require 'test/unit'
require '../JSONParseTool/json_to_graph'

class TestJSONToGraph < Test::Unit::TestCase

  # test to check if the cities from the url and the vertices of the json graph are equal
  def test_vertices

    puts 'test vertices in json graph'

    #make your own city set from the json url
    url = 'https://wiki.cites.illinois.edu/wiki/download/attachments/502596813/map_data.json?version=1&modificationDate=1408551729000&api=v2'
    dict = JSON.parse open(url).read
    city_set = [].to_set

    # populate set with cities from JSON file
    cities_list = dict["metros"]
    cities_list.each { |city_dict| city_set.add(city_dict["code"])}

    # create a json graph and assert that the city_set and the set of vertices are equal
    test_json_graph = JSONToGraph.new
    assert_equal(city_set, test_json_graph.json_graph_api.list_vertices)

  end

  # test to check if the routes from the url and the edges of the json graph are equal
  def test_edges

    puts 'test edges in json graph'

    # make your own route set from the url
    url = 'https://wiki.cites.illinois.edu/wiki/download/attachments/502596813/map_data.json?version=1&modificationDate=1408551729000&api=v2'
    dict = JSON.parse open(url).read
    route_set = [].to_set

    # populate the routes_set with routes from the json file
    routes_list = dict["routes"]
    routes_list.each {|route| route_set.add("#{route["ports"][0]}-#{route["ports"][1]}")}

    # create a json graph and assert that the routes_set and the list of edges are equal
    test_json_graph = JSONToGraph.new
    assert_equal(route_set, test_json_graph.json_graph_api.list_edges)

  end

end