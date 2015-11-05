# ios-decal-proj4

Name of App:
    Speed

Project Owner:
    Dana Mun

Purpose
    This app is a game for people who like to see how fast they can respond to things. 

Features
    This game will consist of a 3 by 3 grid. It will be a game where the user touches the lit up pad and get as many touches as possible within a given time, and the pads will be lit in random places. There will be three different colors. Read means touch once, yellow means touch twice, and green means touch three times. You level up in the game whenever you break new scores. More levels you go up, more grids and more colors will be added. 

Control Flow
    You go in and will see a start button, timer, points, and the grid. Once you play start, you play the game and accumulate as many points as possible as the timer ticks on. When the timer goes off, the amount of points you have is the amount that you gained. There is a home page that keeps track of your top ten highest scores and date. 

Implementation
    Model
        RandomColorGeneratorModel(Simple class that gives you a random color)
        RandomPlaceGeneratorModel(simple class that gives you a random grid place)
        TimerModel(keeps track and displays the start time and end time)
        PointsModel (Your points go up by which grids you touch)
        LevelModel (provides number of grids and colors)

    View
        TopTenScoresTableView
        MainPageGameView

    Controller
        TopTenScoresViewController
        MainPageGameViewController
