# CSCI 5611 Project 4 - The 4th Ring of Donut Hell

By: Michael Cauthorn (cauth006), Jacob Malin (malin146)

## Final State

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; We created a 4-dimensional interactive maze that is generated by a kd-tree. The program starts with a hollow cube to generate the maze in. Then a recursive kd tree generation function starts by creating a wall oriented in the w-direction and two more sub-trees on either side of the wall. As sub-trees are generated, the orientation of the walls is cycled through x, y, z, and w. The player is represented by a camera in one corner of the maze and donut goals are located in every room of the maze. The user can use ‘wasd’ as well as the arrow keys to move forwards, backwards, left, and right as in a normal first-person game however they can also move “zig” and “zag” in the w-axis using ‘q’ and ‘e’ and rocket themselves up using the space bar. The player's location in the w-axis is represented by a UI bar as walls oriented in the w-axis are not normally visible to the user. A menu and escape menu were also added to the game so that the user could change the complexity of the game, which spawns more sub-trees the higher it is, as well as a “hell mode”, which removes the doorway-indicating wireframes for an added challenge. In the main menu, one has a good visualizations of the w-axis walls which are not easily visible in-game, they appear as green cubes that bink in and out of existance as the main menu circles around the cube in the x, z, and w dimensions.

https://media.github.umn.edu/user/19560/files/5c7a7a32-d45c-47a5-9a02-01126932d693

<p align="center">
    <em>video 1: A video of a user traversing the maze </em>
</p>

## Key Algorithms and Computational Bottlenecks

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The key algorithm was the kd-tree. We recursively spilt the area of the map into two uneven sections based on a random number. As this process was repeated we made sure the walls would not spawn over doors by keeping track of an array of door locations that cause the random number generator to reroll if it landed too close to the door. Additionally, we made a precaution against rooms becoming too small and a set number of layers the recursion would maximally travel. If a wall was unable the spawn under these conditions after a set number of tries the recursion would stop, which leads to intersting uneven distribution of rooms.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The approach of using a kd-tree allowed us to minimize collision detection time and ensure all parts of the maze could be accessed. The character only needs to collide with walls in their current room which we could access by traversing the tree. Other collisions do not need to be calculated as the user has no way to collide with those walls. Because of this, the program is not very computationally complex and has no lag issues even at our highest complexity. Whenever a wall was spawned in the kd-tree it was also assigned a door and thus we know every part of the maze is accessible without having to know the specific solution.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; In other cases of optimization, it was not as clear how to utilize the kd-tree. For example, when displaying the donuts we don’t want to only display the donut in the current room because the user can see through doors and it would be jarring to make the donut materialize when the user enters the room the previously perceived to be donutless. We ended up rendering all parts of the maze, donuts and walls, at all times which is the largest computational bottleneck. Since the donuts are the most complex models that we use, at some point the donuts will overwhelm the computer.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The maze can be scaled up in two ways, the maze can become more complex, by increasing the number of layers in the kd-tree or it can become bigger by extending the outer wall boundaries. Complexity is limited because of the constraints on inner room size case sub-trees to not spawn and thus increasing the complexity will have reduced effect as the complexity increases. Increasing the size of the maze does result in a noticeable slowdown because of the rendering previously mentioned. However, the game runs smoothly with 1000s of rooms which is more than any reasonable human would want to explore.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A notable interaction between gameplay design choices and our main algorithm, the kd-tree, is that for the kd-tree to spawn the largest number of rooms, the walls must be spawned as close to the center as possible. However, this created very cube-like and boring mazes, and so some complexity had to be sacrificed in order to maintain more intersting map genration. To this effect, we ended up generating the first wall in the kd-tree within a small range from the center, and for all subsequent walls, we generated two possible walls and chose the one closest to the center. This largely prevented the spawning of lopsided mazes, while still maintaining random-looking room generation.

## Gameplay

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; When the maze is generated a donut will spawn in every room and a counter will be displayed to the user indicating how many donuts are in the maze. As the user traverses the maze picking up donuts, a counter will indicate how many more donuts they have left to find. The user will have to move along the 4 different axes of 4D space in an attempt to acquire these donuts.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Movement along the x, z, and w axis was implemented in a standard velocity-based approach. As long as the specific button is being pressed the user will move at a constant velocity in that direction and immediately stop if the button is released. Movement along the w-axis looks different than normal motion because the character will stand still in 3D space while the motion is happening, however, the implementation of this motion is identical to that for the x and z motion. To make it clear to the user that they are making progress, the UI-bar at the bottom tells the user where they are in the w-axis.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Motion along the y-axis is acceleration-based. We imagined the character has a jet pack and that they are influenced by gravity. To move up (negative y direction because processing is a gremlin) the user can hold the space bar and build up speed to fly. When space is released gravity will inevitably bring the user back to the ground. To prevent too much speed from getting built up velocity is set to 0 when the user hits their head on the ceiling or touches the ground.

## Progress 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; At the very beginning of the project, we were not sure what the final state would look like. This is beacuse we wanted to try and represent a fourth spacial dimension in a way that is logically consistent with the other dimensions, and similarly a kd-tree could be extended to work in an arbitrary number of dimensions. An initial sketch of the project can be seen in figure 1 below. (In which the figure is inacurately notated with zap and zip, where correctly zig is the “left” of the w-axis and zag is the “right”.)

<p align="center">
  <img width="550" alt="initial sketch" src="https://media.github.umn.edu/user/19575/files/c8fc3c8d-bfab-40fc-a311-0b5b3d25af66">  
</p>

<p align="center">
    <em>figure 1: initial sketch </em>
</p>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The core idea for the fourth dimension is already present in this early sketch as the hole in the wall develops as the user moves along the fourth dimension. At this point, we had some sense that a wall in the w plane should be a cube but it was not clear how the user would interact with this kind of wall. 

In the next progress report, we had a very basic scene implemented. Video 2 shows a tree that comes in and out of view as the player moves in w. 

https://media.github.umn.edu/user/19575/files/5c42b11c-105a-4d5a-96e8-4a80d1822966

<p align="center">
    <em>video 2: tree but no kd-tree </em>
</p>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; At this point, we decided a UI bar would be the best way to communicate to the user where they were in the w axis, as shown in figure 2. The code was still very underdeveloped at this point, any object that appeared on the screen was coded directly, the collision was not general and the KD-tree was still not present. There was a real tree there though that calls back to an earlier idea we had to make a scene that morphs into another scene. At this point, jumping was the way to move along the y-axis and we had planned for ladders to spawn for the player to climb.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The UI bar was especially difficult to implement, as we had to figure out a way to display objects in front of the camera that moved with the camera and also rotated with the camera. After a lot of trial and error, we realised that the rotation code could be adapted directly from the camera’s rotation code, which helped us reach a solution much faster. At this point each object on the UI bar was hard-coded, we abstract our rotation math much later.

<p align="center">
  <img width="527" alt="3d1" src="https://media.github.umn.edu/user/19575/files/add1a0cc-c8de-4b8b-908d-999540178864"> 
</p>

<p align="center">
    <em>figure 2: the w-axis UI bar </em>
</p>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A later progress report (Video 3) shows wall generation and motion through a w-doorway. Though it looks very close to the final product, collision at this point had still not been fully implemented. Lots of things from this stage did make it to the final product including door frames and the multi colored walls. We did also at this stage attempt to implement point lights to make it more obvious where the player was in relation to the scenery, however becuase of how the walls are drawn as multiple boxes, this was near impossible with processing’s limitations, so we stuck with ambient lighting.


https://media.github.umn.edu/user/19575/files/085c7d11-b93c-4c9e-89ae-2de83c641eac


<p align="center">
    <em>video 3: movement through doors and w-doors </em>
</p>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The hardest parts of making progress were not what we expected. Many hours went into developing collisions on the inside of doorways whereas walls and doors in the fourth dimension ended up being a simple variation of code from the other dimensions. The kd-tree ended up nicely extrapolating into more dimensions but we several times got stuck trying to debug issues of deep and shallow copying.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Our plan for the features we wanted to include in the maze evolved during its development. Originally we wanted the user to spawn in one corner of the world and a singular donut to spawn in the other, however, in the end, we decided to spawn donuts in every room so the user is incentivized to explore more of the environment. Door frames were added at some point in development so users could predict where the door will open while still maintaining the monochrome wall, this was done to indicate that the walls are a continuous solid and there is actually nothing special about where the doorway was going to appear. W-walls were added to the UI bar so the user would know how much of the w-space was available to them. As well, only the closest w-walls are displayed to give the user limited visiblilty into the w-axis just like the other dimensions. Similarly, when standing in a w-doorway, the next closest w-wall is displayed since the user is “looking” through the doorway. And a title menu and escape menu were added to make the maze feel more like a game.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Still more ideas ended up going unimplemented because they were deprioritized. At points in development, we proposed a screen morphing effect as the user moves in w, roguelike elements such as monsters and traps, and arrows pointing the user to the closest donut.

## Peer feedback

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Feedback was wildly varied. Many different ideas were presented by our peers and not all of them ended up making it to the final cut. Several students suggested we focus our attention on getting collision working which we did end up successfully accomplishing. Others wanted a different color scheme, while some enjoyed the multiple colors which we discussed for a while and decided to lean into the multi-chromatic maze. One touch-up we made to coloring in this regard was to slightly vary the colors of same-axis walls so they would not blend together. This especially helped in locating ceiling doors.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A few more reach goals suggested by peers was a monster roaming the maze which we did consider but decided the user has enough to think about just getting used to 4D space. Other suggestions in a similar vein included more unique objects in the maze and powerups. Mostly the idea was that rooms were uninteresting and hard to navigate without distinct features. This partially influenced our decision to make walls and doors thicker and add a donut to every room. One comment did suggest to smooth out the transition through w-doorways which we did by making the w-walls thicker, as well as better indicating on the UI when a user was inside of the w-doorway.


## Relation to state-of-the-art

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Matsumoto and Ogawa<sup>[1](https://www.math.kyoto-u.ac.jp/~kaji/papers/SIGGRAPH2019_Polyvision_final.pdf)</sup> recently released a paper detailing the state of the art for 4-d animation. They cross-referenced many different ways of making a 4-d interactive and presented their own approach with 4 screens displaying space from any choice of 3 of the 4 dimensions. 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Like Matsumoto and Ogawa^1 we created a 4-d scene for the user to explore from the first person. However, in our implementation, the user can never see a different choice of axes in the same way they see along x,y, z space. Instead, the bar at the bottom of the user's screen communicates to them where they are in w-space in a much more compact, if less abounding, manner. 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; When brainstorming how we wanted users to interact with the fourth dimension we considered all of the methods described in this paper. Our implementation most closely resembles Weeks^2 which discreetly jumped between the dimensions by changing what color line the user was moving on. Our method was continuous but like Weeks^2 did not deal with a rotation of the user in four space like Matsumoto and Ogawa^1 and others were able to handle.
 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; In class, kd-trees were discussed both as a method for creating procedurally generated content as well as a method for minimizing computation complexity during run time. We implemented both features of kd-trees in the project as a tree serves both to create the maze, much like how the rouge dungeon was built, and the save collision computation. 

## Future Improvements
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; If we were given more time to improve upon the code we were making the largest optimization that could be added would be finding nearby rooms. If we were able to solve this problem then the computation bottleneck of rendering the entire maze would be made obsolete as we would only need to render those nearby rooms. This would of course be hard to pin down exactly how nearby the rooms need to be. The different parts of the tree might need to keep track of neighbors and potentially neighbors neighbors in the case that the user looks through 2 doors across a room. If this was kept track of only the room the user is in and its neighbors up to some layer would need to be displayed which would greatly reduce the number of unnecessary donuts and walls that are appearing far out of the user's vision.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kd-trees ended up being a neat way to make a large and complex maze that was guaranteed to be connected. However, its connectivity ended up also being a cost at the same time. Though there was a random generation, if the user understands the recursive nature, solving a maze becomes quite trivial. Locating the first wall will let to orient yourself and make solving the maze a similar process rather than a truly new experience every run. The only way to work around this would be to give up on the kd implementation and make a maze that is not self-similar. 

## Citations and Libraries

- [Matsumoto and Ogawa's paper on 4D rotation animation](https://www.math.kyoto-u.ac.jp/~kaji/papers/SIGGRAPH2019_Polyvision_final.pdf)
- [Weeks's work on 4D games](http://geometrygames.org/)
- The provided Camera by Liam Tyler was used as the base for menu_camera.pde and player.pde, as well as the rotation math for menu_ui.pde and ui.pde
- The provided Vec3 library was adapted into a Vec4 library


