ios-decal-proj4

## Name of Application
   Speed
## Project Owner
   Dana Mun
## Purpose
   This app is a game for people who like to see how fast they can respond to things. 
## Features
   * This game will consist of a 3 by 3 grid. 
   * It will be a game where the user touches the lit up pad and get as many touches as possible within a given time, and the pads will be lit in random places. 
   *There will be three different colors that will be introduced every level.
	- Level 1
		* Yellow means tap once. + 10 pts.
		* Red menas tap twice. + 20 pts.
	- Level 2
		* Green means hold for one second. + 30 pts.
		* Black tapped. - 10 pts.
	- Level 3
		* Bomb means lose game.
	- Level 4
		* Blue means drage outwards. + 5 pts.    
    * You level up in the game whenever you break the 1500 mark at the current level.  
    * You can tweet your scores.

## Control Flow
    You go in and will see a start button, timer, points, and the grid. 
    Once you play start, you play the game and accumulate as many points as possible as the timer ticks on. 
    When the timer goes off, the amount of points you have is the amount that you gained. 
    There is a table view page that keeps track of your top ten highest scores and date. 
## Implementation
   * Model
       - GameModel: keeps track of score, level, and generates random color and grid space.
   * View
       - TopTenScoresTableView
       - MainPageGameView
       - RulesView
   * Controller
       - TopTenScoresViewController
       - MainPageGameViewController
