# CSCI 5611 Project 4 - Final Project Report

By: Michael Cauthorn (cauth006), Jacob Malin (malin146)

## Final State

  We created a 4-dimensional interactive maze generator based on a kd-tree. Upon running the program. A hollow cube is created to enclose the space the maze will generate under. Then a recursive kd tree creates a wall oriented in the w-direction and two more kd-trees on either side of the wall. During this generation, the orientation of the walls is cycled through x,y,z, and w. The player is represented by a camera in one corner of the maze and donut goals are located in every room of the maze. The user can use ‘w’, ’a’, ’s’, and ’d’ to move as in a normal first-person game however they can also move “zip” and “zap” across the w-axis using ‘q’ and ‘e’ and rocket themselves up using the space bar. The player's location in the w-axis is represented by a UI bar. Walls oriented in the w-axis are not visible to the user however motion is tracked along the UI bar. 

[video]  

A video of a user traversing the maze 

## Key algorithms and computational bottlenecks 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The key algorithm was the kd-tree. We recursively spilt the area of the map into two uneven sections based on a random number. As this process was repeated we made sure the walls would not spawn over doors by keeping track of an array of door locations that cause the random number generator to reroll if it landed close enough to the door. Additionally, we made a precaution against rooms becoming too small and a set number of layers the recursion would maximally travel. If a wall was unable the spawn under these conditions after a set number of tries the recursion would stop.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The approach of using a k-d tree allowed us to minimize collision detection time and ensure all parts of the maze could be accessed. The character only needs to collide with walls in their current room which we could access by traversing the tree. Other collisions would not be calculated because the user would have to get out of the room they are in before they could collide with such walls. Only taking into account the possible collins saved many various computations every tic and allowed the program to grow much larger. Whenever a wall was spawned in the kd-tree it also had a door thus we know every part of the maze is accessible without having to know the specific solution.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; In other cases of optimization, it was not as clear how to utilize the k-d tree. For example, when displaying the donuts we don’t want to only display the donut in the current room because the user can see through doors and it would be jarring to make the donut materialize when the user enters the room the previously perceived to be donutless. We ended up rendering all parts of the maze (donuts and walls) at all times which is the largest computational bottleneck. 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The maze can be scaled up in two ways, the maze can become more complex, by increasing the number of layers in the kd-tree or it can become bigger by extending the outer wall boundaries. Complexity is limited because of the constraints on inner room size thus increasing the complexity will still result in a stable maze even at very large numbers. Increasing the size of the maze does result in a noticeable slowdown because of the rendering previously mentioned. However, the game runs smoothly with 1000s of rooms which is more than any reasonable human would want to explore.

## Gameplay

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; When the maze is generated a donut will spawn in every room and a counter will be displayed to the user indicating how many donuts are in the maze. As the user traverses the maze picking up donuts a counter will indicate how many more donuts they have left to find. The user will have to move along the 4 different axes of 4-d space in an attempt to acquire these donuts. 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Movement along the x, z, and w axis was implemented in a standard velocity-based approach. As long as the specific button is being pressed the user will move at a constant velocity in that direction and immediately stop if the button is released. Movement along the w-axis looks different than normal motion because the character will stand still in 3-d space while the motion is happening, however, the implantation of this motion is identical to that for the x and z motion. To make it clear to the user that they are making progress the UI-bar at the bottom will tell the user where they are in the w-axis and move when they do. 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Motion along the y-axis is acceleration-based. We imagined the character has a jet pack and is influenced by gravity. To move up (negative y direction because processing is a gremlin) the user can hold the space bar and build speed and being to fly. When space is released gravity will inevitably bring the back to the ground. To prevent too much speed from getting built up velocity is set to 0 when the user hits their head on the ceiling or touches the ground. 

## Progress 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; At the very beginning of the project, we were not sure what the final state would look like. At some point, we decided we wanted to try and represent a fourth spacial dimension and that a kd-tree could be extended to work in an arbitrary number of dimensions. An initial sketch of the project can be seen in figure 1 below.

<p align="center">
  <img width="550" alt="sketch1" src="https://media.github.umn.edu/user/19575/files/c8fc3c8d-bfab-40fc-a311-0b5b3d25af66">  
</p>

<p align="center">
    <em>figure 1: inital scketch </em>
</p>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The core idea for the fourth dimension is already present in this early sketch as the hole in the wall develops as the user moves along the fourth dimension. At this point, we had some sense that a wall in the w plane should be a cube but it was not clear how the user would interact with this kind of wall. 

In the next progress report, we had a very basic scene implemented. Video 2 shows a tree that comes in and out of view as the player moves in w. 

<p align="center">
https://media.github.umn.edu/user/19575/files/5c42b11c-105a-4d5a-96e8-4a80d1822966
</p>

<p align="center">
    <em>Video 2: tree but no kd-tree </em>
</p>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; At this point, we decided a UI bar would be the best way to communicate to the user where they were in the w axis. as shown in figure 2. The code was still very underdeveloped at this point, any object that appeared on the screen was coded directly, the collision was not general and the KD-tree was still not present. There was a real tree there though that calls back to an earlier idea we had to make a scene that morphs into another scene. At this point, jumping was the way to move along the y-axis and we had planned for ladders to spawn for the player to climb.

<p align="center">
  <img width="527" alt="3d1" src="https://media.github.umn.edu/user/19575/files/add1a0cc-c8de-4b8b-908d-999540178864"> 
</p>

<p align="center">
    <em>figure 2: w-axis UI bar </em>
</p>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A later progress report (Video 3) shows wall generation and motion through a w-door. Though it looks very close to the final product collision at this point had still not been established. Lots of things from this stage did make it to the final product including door frames and ambient lighting. 

<p align="center">
https://media.github.umn.edu/user/19575/files/085c7d11-b93c-4c9e-89ae-2de83c641eac
</p>

<p align="center">
    <em>Video 3: movment through doors and w-doors </em>
</p>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The hardest parts of making progress were not what we expected. Many hours went into developing collisions on the inside of doorways whereas walls and doors in the fourth dimension ended up being a simple variation of code from the other directions. The kd-tree ended up nicely extrapolating into more dimensions but we several times got stuck trying to debug issues of deep and shallow copying. 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Our plan for the features we wanted to include in the maze evolved during its development. Originally we wanted the user to spawn in one corner of the world and the donut to spawn in the other, however, in the end, we decided to spawn donuts in every room so the user is incentivized to explore more of the environment. Door frames were added at some point in development so users could predict where the door will open while still maintaining the monochrome wall. W-walls were added to the ui bar so the user would know how much of the w-space was available to them. And a title and win screen were added to make the maze feel more like a game.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Still more ideas ended up going unimplemented because they were deprioritized. At points in development, we proposed a screen morphing effect as the user moves in w, roguelike elements such as monsters and traps, and arrows pointing the user to the closest donut.

## Peer feedback

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Feedback was wildly varied. Many different ideas were presented by our peers and not all of them ended up making it to the final cut. Several students suggested we focus our attention on getting collision working which we did end up successfully accomplishing. Others wanted a different color scheme which we discussed for a while but decided to lean into the multi-chromatic maze. One touch-up we made to coloring in this regard was to slightly vary the colors of same-axis walls so they would not blend together. This especially helped in locating ceiling doors. 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A few more reach goals suggested by peers was a monster roaming the maze which we did consider but decided the user has enough to think about just getting used to 4-d space. Other suggestions in a similar vein included more unique objects in the maze and powerups. Mostly the idea was that rooms were uninteresting and hard to navigate without distinct features. This partially influenced our decision to make walls and doors thicker a add a donut to every room.


## Relation to state-of-the-art

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Matsumoto and Ogawa^1 recently released a paper detailing the state of the art for 4-d animation. They cross-referenced many different ways of making a 4-d interactive and presented their own approach with 4 screens displaying space from any choice of 3 of the 4 dimensions. 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Like Matsumoto and Ogawa^1 we created a 4-d scene for the user to explore from the first person. However, in our implementation, the user can never see a different choice of axes in the same way they see along x,y, z space. Instead, the bar at the bottom of the user's screen communicates to them where they are in w-space in a much more compact, if less abounding, manner. 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; When brainstorming how we wanted users to interact with the fourth dimension we considered all of the methods described in this paper. Our implementation most closely resembles Weeks^2 which discreetly jumped between the dimensions by changing what color line the user was moving on. Our method was continuous but like Weeks^2 did not deal with a rotation of the user in four space like Matsumoto and Ogawa^1 and others were able to handle.
 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; In class, kd-trees were discussed both as a method for creating procedurally generated content as well as a method for minimizing computation complexity during run time. We implemented both features of kd-trees in the project as a tree serves both to create the maze, much like how the rouge dungeon was built, and the save collision computation. 

## Future Improvements
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; If we were given more time to improve upon the code we were making the largest optimization that could be added would be finding nearby rooms. If we were able to solve this problem then the computation bottleneck of rendering the entire maze would be made obsolete as we would only need to render those nearby rooms. This would of course be hard to pin down exactly how nearby the rooms need to be. The different parts of the tree might need to keep track of neighbors and potentially neighbors neighbors in the case that the user looks through 2 doors across a room. If this was kept track of only the room the user is in and its neighbors up to some layer would need to be displayed which would greatly reduce the number of unnecessary donuts and walls that are appearing far out of the user's vision.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kd-trees ended up being a neat way to make a large and complex maze that was guaranteed to be connected. However, its connectivity ended up also being a cost at the same time. Though there was a random generation, if the user understands the recursive nature, solving a maze becomes quite trivial. Locating the first wall will let to orient yourself and make solving the maze a similar process rather than a truly new experience every run. The only way to work around this would be to give up on the kd implementation and make a maze that is not self-similar. 
