//
//  EndScene.swift
//  Space Defender
//
//  Created by Bew Games on 22/04/2015.
//  Copyright (c) 2015 Bew Games. All rights reserved.
//

import Foundation
import SpriteKit

class EndScene : SKScene {
    
    var RestartButton : UIButton!
    var Highscore : Int!
    var Score : Int!
    var HighscoreLabel : UILabel!
    var ScoreLabel : UILabel!
    
    override func didMoveToView(view: SKView) {
        scene?.backgroundColor = UIColor.whiteColor()
        
        RestartButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width / 3, height: 30))
        RestartButton.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 4)
        
        RestartButton.setTitle("Restart", forState: UIControlState.Normal)
        RestartButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        RestartButton.addTarget(self, action: Selector("Restart"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view?.addSubview(RestartButton)
        
        var YourScore = NSUserDefaults.standardUserDefaults()
        Score = YourScore.valueForKey("YourScore") as! NSInteger
        
        var HighscoreDefault = NSUserDefaults.standardUserDefaults()
        Highscore = HighscoreDefault.valueForKey("Highscore") as! NSInteger
        
        ScoreLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width / 3, height: 30))
        ScoreLabel.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 2)
        ScoreLabel.textColor = UIColor.blackColor()
        ScoreLabel.text = "Score : " + "\(Score)"
        ScoreLabel.textAlignment = NSTextAlignment.Center
        self.view?.addSubview(ScoreLabel)
        
        HighscoreLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 30))
        HighscoreLabel.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 1.85)
        HighscoreLabel.textColor = UIColor.blackColor()
        HighscoreLabel.textAlignment = NSTextAlignment.Center
        HighscoreLabel.text = "Your Highscore : " + "\(Highscore)"
        self.view?.addSubview(HighscoreLabel)
    }
    
    func Restart() {
        RestartButton.removeFromSuperview()
        HighscoreLabel.removeFromSuperview()
        ScoreLabel.removeFromSuperview()
        self.view?.presentScene(GameScene(), transition: SKTransition.crossFadeWithDuration(0.3))
    }
}