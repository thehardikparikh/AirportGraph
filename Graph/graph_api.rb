
require_relative 'vertex'
require 'set'

class GraphAPI

  # Basic constructor for a Graph
  def initialize

    #the graph Hash will have vertex labels for keys and vertex objects for values
    @graph = {}

  end

  # method to add a vertex to the graph
  # @param [String] label  label of the vertex
  # @param [Hash] data data held by the vertex, default set to empty Hash
  # @param [Hash] edges edges of the vertex, default set to empty Hash
  def add_vertex(label, data = {}, edges = {})

    #store the vertex in the graph
    if not @graph.has_key?(label)
      @graph.store(label, Vertex.new(label, data, edges))
    end

  end

  # method to remove a vertex from the graph
  # @param [String] label the label of the vertex that we want to remove
  def remove_vertex(label)

    if @graph.has_key?(label)
      # for each vertex object in the graph Hash, delete the label from the edges Hash
      @graph.each_value {|vertex_object| vertex_object.edges.delete(label)}

      # delete the label from the graph Hash
      @graph.delete(label)
    end

  end

  # method to add an edge to the graph
  # @param [String] source the source vertex of the edge
  # @param [String] destination the destination vertex of the edge
  # @param [Hash] edge_data the default/optional data that the edge will hold
  def add_edge(source, destination, edge_data = {})

    # if the source if not in the graph add it
    if not @graph.has_key?(source)
      self.add_vertex(source)
    end

    # if the destination is not there in the graph add it
    if not @graph.has_key?(destination)
      self.add_vertex(destination)
    end

    # add the destination of the edge (key) and the edge data (value) to the edges hash of
    # source
    @graph[source].edges[destination] = edge_data

  end

  # method to remove an edge from the graph
  # @param [String] source the label of source vertex of the edge that we want to remove
  # @param [String] destination the label of the destination of the edge that we want to remove
  def remove_edge(source, destination)

    if @graph.has_key?(source) and @graph.has_key?(destination)
      @graph[source].edges.delete(destination)
    end

  end

  # method to print the edges of the graph
  def print_edges

    @graph.each {|label, vertex| vertex.edges.each_key { |destination| puts "#{label}->#{destination}"}}

  end

  # method to print the vertices of the graph
  def print_vertices

    @graph.each_key {|label| puts "#{label}"}

  end

  # method to get a list of vertices in the graph
  # @return [Set] list of vertices in the graph
  def list_vertices

    vertex_set = [].to_set
    @graph.each_key {|label| vertex_set.add(label)}
    return vertex_set

  end

  # method to get the set of edges in the graph
  # @return [Set] the set of edges in the graph represented by strings such that
  #               each edge is "source->destination"
  def list_edges

    edge_set = [].to_set
    @graph.each {|label, vertex| vertex.edges.each_key {|destination| edge_set.add("#{label}-#{destination}")}}
    return edge_set

  end

  # method to get the data of the vertex label
  # @param [String] label label of the vertex whose data we want
  # @return [Hash] a hash containing the data for the vertex
  def get_vertex_data(label)

    # if the vertex is present return the corresponding data dictionary
    if @graph.has_key?(label)
      return @graph[label].data
    else
      return nil
    end

  end

  # method to get the outgoing edges from the vertex label
  # @param [String] label label of the vertex whose edges we want
  # @return [Hash] a hash containing the destination (key) and edge info
  def get_outgoing_edges(label)

    if @graph.has_key?(label)
      return @graph[label].edges
    else
      return nil
    end

  end

  # method to count the number of incoming edges of the given label
  # @param [String] label of the vertex in question
  # @return [Integer] count of the incoming edges of the vertex
  def count_incoming_edges(label)

    count = 0
    if @graph.has_key?(label)
      # for each vertex object in the graph Hash, if the label is present in the edges
      #increase the count
      @graph.each_value do |vertex_object|
          if not vertex_object.edges.empty?
            if vertex_object.edges.has_key?(label)
              count+=1
            end
          end
      end
    end

    return count

  end

  attr_accessor :graph
end