require 'test/unit'
require '../Graph/graph_api'

class TestGraphAPI < Test::Unit::TestCase

  # method adds 5 vertices to the graph and asserts that the set of vertices
  # added matches the set of vertices returned by the list_vertices function of the graph
  def test_add_vertex_valid

    puts 'Test add vertex valid'
    graph = GraphAPI.new
    vertex_list = ['A','B','C','D','E'].to_set
    graph.add_vertex('A')
    graph.add_vertex('B')
    graph.add_vertex('C')
    graph.add_vertex('D')
    graph.add_vertex('E')

    assert_equal(graph.list_vertices, vertex_list)

  end

  # method adds 5 vertices to the graph and repeats the addition of one more vertex
  # checks whether the repeated one is not added as well
  def test_add_vertex_invalid

    puts 'Test add vertex invalid'
    graph = GraphAPI.new
    vertex_list = ['A','B','C','D','E'].to_set
    graph.add_vertex('A')
    graph.add_vertex('B')
    graph.add_vertex('C')
    graph.add_vertex('D')
    graph.add_vertex('E')
    graph.add_vertex('A') # trying to add A again

    assert_equal(graph.list_vertices, vertex_list)

  end

  # tries to remove a vertex that was added to the graph
  # asserts whether the list returned by the graph and the original set of vertices
  # don't match
  def test_remove_vertex_valid

    puts 'Test remove vertex valid'
    graph = GraphAPI.new
    vertex_list = ['A','B','C','D','E'].to_set
    graph.add_vertex('A')
    graph.add_vertex('B')
    graph.add_vertex('C')
    graph.add_vertex('D')
    graph.add_vertex('E')

    puts 'Removing vertex E'

    graph.remove_vertex('E')

    assert_not_equal(graph.list_vertices, vertex_list)

  end

  # tries to remove a vertex that was not added at all
  # asserts to see if the original list and the list returned by the graph match
  def test_remove_vertex_invalid

    puts 'Test remove vertex invalid'
    graph = GraphAPI.new
    vertex_list = ['A','B','C','D','E'].to_set

    graph.add_vertex('A')
    graph.add_vertex('B')
    graph.add_vertex('C')
    graph.add_vertex('D')
    graph.add_vertex('E')

    puts 'Removing vertex K'

    graph.remove_vertex('K')
    assert_equal(graph.list_vertices, vertex_list)

  end

  # adds edges to the graph and asserts if the set of edges sent by the graph matches
  # the original set of edges that we added to the graph
  def test_add_edge_valid

    puts 'Test add edge valid'
    graph = GraphAPI.new
    edge_set = ['A-B','B-C','C-D','D-E','E-A','B-A'].to_set #list of edges being added

    graph.add_edge('A','B')
    graph.add_edge('B','A')
    graph.add_edge('B','C')
    graph.add_edge('C','D')
    graph.add_edge('D','E')
    graph.add_edge('E','A')

    assert_equal(edge_set, graph.list_edges) #compare with the list of edges from the graph

  end

  # adds a bunch of edges to the graph. Removes one of those edges and asserts that
  # there is no match between the set of edges from the graph and the original set of edges
  def test_remove_edge_valid

    puts 'Test remove edge valid'
    graph = GraphAPI.new
    edge_set = ['A-B','B-C','C-D','D-E','E-A','B-A'].to_set #list of edges being added

    graph.add_edge('A','B')
    graph.add_edge('B','A')
    graph.add_edge('B','C')
    graph.add_edge('C','D')
    graph.add_edge('D','E')
    graph.add_edge('E','A')

    graph.remove_edge('B','A')
    assert_not_equal(edge_set, graph.list_edges) #compare with the list of edges from the graph

  end

  # adds a bunch of edges to the graph. removes an edge which wasn't even present in the graph
  # asserts that the original set and the set sent by the graph match
  def test_remove_edge_invalid

    puts 'Test remove edge invalid'
    graph = GraphAPI.new
    edge_set = ['A-B','B-C','C-D','D-E','E-A','B-A'].to_set #list of edges being added

    graph.add_edge('A','B')
    graph.add_edge('B','A')
    graph.add_edge('B','C')
    graph.add_edge('C','D')
    graph.add_edge('D','E')
    graph.add_edge('E','A')

    graph.remove_edge('A','C')
    assert_equal(edge_set, graph.list_edges) #compare with the list of edges from the graph

  end

  # adds a A to 4 of the vertices and asserts that the count of incoming edges is 4
  def test_count_incoming_edges

    puts 'Test count incoming edges'
    graph = GraphAPI.new

    graph.add_edge('A','B')
    graph.add_edge('B','A')
    graph.add_edge('C','A')
    graph.add_edge('D','A')
    graph.add_edge('E','A')

    assert_equal(4, graph.count_incoming_edges('A')) #compare with the list of edges from the graph

  end




end