//
//  GameViewController.swift
//  Speed
//
//  Created by Da Y Mun on 12/5/15.
//  Copyright © 2015 danamun. All rights reserved.
//

import UIKit
import Social

var scoreTable = [Int]()

class GameViewController: UIViewController {
    @IBOutlet var time: UILabel!
    @IBOutlet var score: UILabel!
    @IBOutlet weak var level: UIImageView!
    
    @IBOutlet var tweet: UIButton!
    @IBOutlet var grid1: UIButton!
    @IBOutlet var grid2: UIButton!
    @IBOutlet var grid3: UIButton!
    @IBOutlet var grid4: UIButton!
    @IBOutlet var grid5: UIButton!
    @IBOutlet var grid6: UIButton!
    @IBOutlet var grid7: UIButton!
    @IBOutlet var grid8: UIButton!
    @IBOutlet var grid9: UIButton!
    @IBOutlet var start: UIButton!
    
    var counter: Int = 0
    var timer = NSTimer()
    var greenTimer = NSTimer()
    var buttonList = [UIButton!]()
    let colorList = ["Yellow": UIColor.yellowColor(), "Red": UIColor.redColor(), "Green": UIColor.greenColor(), "Black": UIColor.blackColor(), "Bomb": UIColor.whiteColor(), "Blue": UIColor.blueColor()]
    var gameModel: GameModel = GameModel()

    let bomb = UIImage(named: "bomb")
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonList.append(grid1)
        buttonList.append(grid2)
        buttonList.append(grid3)
        buttonList.append(grid4)
        buttonList.append(grid5)
        buttonList.append(grid6)
        buttonList.append(grid7)
        buttonList.append(grid8)
        buttonList.append(grid9)
        level.image = UIImage(named: "level" + String(gameModel.getLevel()))
        self.navigationItem.title = "Speed"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func startGame(sender: AnyObject) {
        for button in buttonList {
            button.backgroundColor = UIColor.whiteColor()
        }
        counter = 0
        score.text = "0"
        gameModel.resetScore()
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateTime"), userInfo: nil, repeats: true)
        
    }
    
    func updateTime() {
        if counter < 10 {
            time.text = "00:0" + String(counter++)
        } else if counter < 40 {
            time.text = "00:" + String(counter++)
        } else if counter >= 40 {
            timer.invalidate()
            endGame()
        }
        updateBoard()
    }
    
    func endGame() {
        saveScore()
        if gameModel.didLevelUp() {
            gameModel.levelUp()
            level.image = UIImage(named: "level" + String(gameModel.getLevel()))
        }
    }
    
    func saveScore() {
        //save score
        scoreTable.append(gameModel.getTotalPoints())
    }
    
    func updateBoard() {
        let color = gameModel.getNewColor()
        let gridNum = gameModel.getNewPosition()
        
        let button = buttonList[gridNum]
        button.backgroundColor = colorList[color]
        switch(color){
        case "Yellow" :
            button.addTarget(self, action: "Yellow:", forControlEvents: .TouchUpInside)
        case "Red":
            button.addTarget(self, action: "Red:", forControlEvents: .TouchDownRepeat)
        case "Green":
            let hold = UILongPressGestureRecognizer(target: self, action: "Green:")
            hold.minimumPressDuration = 1.0
            button.addGestureRecognizer(hold)
        case "Black":
            button.addTarget(self, action: "Black:", forControlEvents: .TouchUpInside)
        /*case "Bomb":
            button.setImage(bomb, forState: .Normal)
            button.addTarget(self, action: "Bomb:", forControlEvents: .TouchUpInside)
            NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: Selector("RemoveBomb"), userInfo: nil, repeats: false)
            // but how does this function access button?*/
        case "Blue":
            button.addTarget(self, action: "Blue:", forControlEvents: .TouchDragOutside)
        default:
            print("nothing")
        }
        
    }
    
    func Yellow(sender: UIButton!) {
        gameModel.addPoints(10)
        score.text = String(gameModel.getTotalPoints())
        sender.backgroundColor = UIColor.whiteColor()
        sender.removeTarget(self, action: "Yellow:", forControlEvents: .TouchUpInside)
        updateBoard()
    }
    
    func Red(sender: UIButton!) {
        gameModel.addPoints(20)
        score.text = String(gameModel.getTotalPoints())
        sender.backgroundColor = UIColor.whiteColor()
        sender.removeTarget(self, action: "Red:", forControlEvents: .TouchDownRepeat)
        updateBoard()
    }
    
    func Green(sender: UILongPressGestureRecognizer!) {
        if sender.state == UIGestureRecognizerState.Ended {
            gameModel.addPoints(30)
            score.text = String(gameModel.getTotalPoints())
            let button = sender.view as! UIButton
            button.backgroundColor = UIColor.whiteColor()
            sender.removeTarget(self, action: "Green:")
        }
    }
    
    func Black(sender: UIButton!) {
        gameModel.addPoints(-10)
        score.text = String(gameModel.getTotalPoints())
        sender.backgroundColor = UIColor.whiteColor()
        sender.removeTarget(self, action: "Black:", forControlEvents: .TouchUpInside)
    }
    
    func Bomb(sender: UIButton!) {
        sender.removeTarget(self, action: "Bomb:", forControlEvents: .TouchUpInside)
        sender.setImage(nil, forState: .Normal)
        for button in buttonList {
            button.backgroundColor = UIColor.whiteColor()
        }
        counter = 0
        score.text = "0"
        gameModel.resetScore()
        timer.invalidate()
    }
    
    func RemoveBomb(sender: UIButton!) {
        sender.removeTarget(self, action: "Bomb:", forControlEvents: .TouchUpInside)
        sender.setImage(nil, forState: .Normal)
    }
    
    func Blue(sender: UIButton!) {
        gameModel.addPoints(5)
        score.text = String(gameModel.getTotalPoints())
        sender.backgroundColor = UIColor.whiteColor()
        sender.removeTarget(self, action: "Blue:", forControlEvents: .TouchDragOutside)
    }
    
    // http://www.brianjcoleman.com/tutorial-share-facebook-twitter-swift/
    @IBAction func tweetScoreButton(sender: AnyObject) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter){
            let twitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterSheet.setInitialText("Share on Twitter")
            self.presentViewController(twitterSheet, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Accounts", message: "Please login to a Twitter account to share.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
