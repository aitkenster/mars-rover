require './lib/instructions.rb'
require './lib/robot.rb'
require './lib/world.rb'
require './lib/location.rb'
require './lib/command.rb'

orders = Instructions.new("mars_instructions.txt")
orders.create_world
orders.process_robot_instructions