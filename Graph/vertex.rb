class Vertex

  # Initializer for a Vertex.
  #
  # @param [String] vertex_label the vertex_label of the vertex
  # @param [Hash] data a Hash holding the data of the vertex
  # @param [Hash] edges a Hash holding the outgoing edges from the vertex
  #                     key of edges - vertex_label of the destination vertex
  #                     value of edges - weight of the vertex
  def initialize(vertex_label, data, edges)
    @vertex_label = vertex_label
    @data = data
    @edges = edges
  end

  attr_reader :vertex_label # vertex_label cannot be changed once it is set
  attr_accessor :data # data can be set as well as read
  attr_accessor :edges #edges can be set as well as read
end