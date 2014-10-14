Mars Rover
==========

The surface of Mars can be modelled by a rectangular grid around which robots are able to
move according to instructions provided from Earth. Write a program that
determines each sequence of robot positions and reports the final position of the robot.

###Specification
+ The world is a rectangular and bounded grid.
+ A robot position should consists of a grid coordinate (a pair of integers: x-coordinate followed by
y-coordinate) and an orientation (N, S, E, W for north, south, east, and west).
+ A robot instruction is a string of the letters “L”, “R”, and “F” which represent left, right and forward.
+ A robot that moves off an edge of the grid is lost.
+ Lost robots leave a robot “scent” that prohibits future robots from dropping off the world at the same grid point at the last grid position the robot occupied before disappearing over the edge.
+ An instruction to move off the world from a grid point from which a robot has been previously lost is ignored by the current robot.
+ The first line of input is the upper-right coordinates of the rectangular world, the lower-left
coordinates are assumed to be 0, 0.
+ The remaining input is a sequence of positions and instructions. 
+ Each robot is processed sequentially.
+ For each robot position/instruction in the input, the output should indicate the final grid
position and orientation of the robot.
+ If a robot falls off the edge of the grid the word “LOST” should be printed after the position and orientation.

#Sample Input

```sh
5 3
1 1 E
RFRFRFRF
3 2 N
FRRFLLFFRRFLL
0 3 W
LLFFFLFLFL
```
#Sample Output

```sh
1 1 E
3 3 N LOST
2 3 S
```

###Technologies used

+ Ruby
+ RSpec
+ Code Climate

###How to set it up

```sh
git clone https://github.com/aitkenster/mars-rover.git
cd mars-rover
bundle install
```

###How to run it

```sh
cd mars-rover
ruby run.rb "mars_instructions.txt"
```

The sample file "mars_instructions.txt" can be substituted for another instructions file.

###How to test it

```sh
cd mars-rover
rspec
``` 
