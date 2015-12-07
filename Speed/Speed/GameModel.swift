//
//  GameModel.swift
//  Speed
//
//  Created by Da Y Mun on 12/5/15.
//  Copyright © 2015 danamun. All rights reserved.
//

import Foundation

class GameModel {
    var totalPoints: Int = 0
    var currentLevel = 1
    var colorsLevel1 = [String]()
    var colorsLevel2 = [String]()
    var colorsLevel3 = [String]()
    var colorsLevel4 = [String]()
    
    init() {
        colorsLevel1 = ["Yellow", "Red"] //2
        colorsLevel2 = colorsLevel1 + ["Green", "Black"] //4
        colorsLevel3 = colorsLevel2 + ["Bomb"] //5
        colorsLevel4 = colorsLevel3 + ["Blue"] //6
    }
    func getLevel() -> Int {
        return currentLevel
    }
    
    func resetScore() {
        totalPoints = 0
    }
    
    func getTotalPoints() -> Int {
        return totalPoints
    }
    
    func addPoints(points: Int) {
        totalPoints += points
    }
    
    func didLevelUp() -> Bool {
        return totalPoints >= 1500
    }
    
    func levelUp() {
        currentLevel += 1
    }
    
    func getNewColor() -> String {
        switch(currentLevel) {
        case 1:
            let number = arc4random_uniform(2)
            return colorsLevel1[Int(number)]
        case 2:
            let number = arc4random_uniform(4)
            return colorsLevel2[Int(number)]
        case 3:
            let number = arc4random_uniform(5)
            return colorsLevel3[Int(number)]
        case 4:
            let number = arc4random_uniform(6)
            return colorsLevel4[Int(number)]
        default:
            return "Black"
        }
    }
    
    func getNewPosition() -> Int{
        return Int(arc4random_uniform(9))
    }
    
}