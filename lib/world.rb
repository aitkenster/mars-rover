class World

	def initialize(x,y)
		create_grid_size(x,y)
	end

	attr_reader :grid

	def create_grid_size(x,y)
		@grid = {}
		(0..x).map{|x| (0..y).map{|y| @grid["#{x},#{y}"] = Location.new}}
	end

end