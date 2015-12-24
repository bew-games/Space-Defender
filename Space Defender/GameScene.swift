//
//  GameScene.swift
//  Space Defender
//
//  Created by Bew Games on 16/04/2015.
//  Copyright (c) 2015 Bew Games. All rights reserved.
//

import SpriteKit

struct PhysicsCategory {
    static let Enemy : UInt32 = 1
    static let Bullet : UInt32 = 2
    static let Player : UInt32 = 3
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var Highscore = Int()
    var Score = Int()
    var ScoreLabel = UILabel()
    var LifeLabel = UILabel()
    
    var player = Player()
    
    override func didMoveToView(view: SKView) {
        
        var HighScoreDefault = NSUserDefaults.standardUserDefaults()
        
        if(HighScoreDefault.valueForKey("Highscore") != nil) {
            Highscore = HighScoreDefault.valueForKey("Highscore") as! NSInteger
        } else {
            Highscore = 0
        }
        
        physicsWorld.contactDelegate = self
        
        self.scene?.backgroundColor = UIColor.blackColor()
        self.scene?.size = CGSize(width: 640, height: 1136)
        self.addChild(SKEmitterNode(fileNamed: "MagicParticle"))
        
        var BulletTimer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: Selector("SpawnBullets"), userInfo: nil, repeats: true)
        
        var EnemyTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("SpawnEnnemies"), userInfo: nil, repeats: true)
        
        player = Player(image: "player.png", scene: self, life : 3)
        
        self.addChild(player)
        
        ScoreLabel.text = "\(Score)"
        ScoreLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        ScoreLabel.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.3)
        ScoreLabel.textColor = UIColor.whiteColor()
        ScoreLabel.textAlignment = NSTextAlignment.Right
        
        LifeLabel = UILabel(frame: CGRect(x: self.size.width - 450, y: 0, width: 100, height: 20))
        LifeLabel.textAlignment = NSTextAlignment.Right
        
        displayCoeurs(player.life, label : LifeLabel)
        
        self.view?.addSubview(ScoreLabel)
        self.view?.addSubview(LifeLabel)
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        var firstBody : SKPhysicsBody = contact.bodyA
        var secondBody : SKPhysicsBody = contact.bodyB
        
        if(firstBody.categoryBitMask == PhysicsCategory.Enemy && secondBody.categoryBitMask == PhysicsCategory.Bullet) {
            CollisionEnnemyWithBullet(firstBody.node as! Enemy, bullet: secondBody.node as! Bullet)
        }
        
        if(firstBody.categoryBitMask == PhysicsCategory.Bullet && secondBody.categoryBitMask == PhysicsCategory.Enemy) {
            CollisionBulletWithEnemy(firstBody.node as! Bullet, enemy: secondBody.node as! Enemy)
        }
        
        if(firstBody.categoryBitMask == PhysicsCategory.Enemy && secondBody.categoryBitMask == PhysicsCategory.Player) {
            CollisionEnemyWithPlayer(firstBody.node as! Enemy, player: secondBody.node as! Player)
        }
        
        if(firstBody.categoryBitMask == PhysicsCategory.Player && secondBody.categoryBitMask == PhysicsCategory.Enemy) {
            CollisionPlayerWithEnemy(firstBody.node as! Player, enemy: secondBody.node as! Enemy)
        }
    }
    
    func CollisionEnnemyWithBullet(enemy : Enemy, bullet : Bullet) {
        CollisionWithBullet(bullet, enemy : enemy)
    }
    
    func CollisionBulletWithEnemy(bullet : Bullet, enemy : Enemy) {
        CollisionWithBullet(bullet, enemy : enemy)
    }
    
    func CollisionWithBullet(bullet : Bullet, enemy : Enemy) {
        enemy.life--
        
        if(enemy.life == 0) {
            enemy.removeFromParent()
            Score += 10
        }
        
        bullet.removeFromParent()
        ScoreLabel.text = "\(Score)"
    }
    
    func CollisionPlayerWithEnemy(player : Player, enemy : Enemy) {
        CollisionWithEnemy(player, enemy : enemy)
    }
    
    func CollisionEnemyWithPlayer(enemy : Enemy, player : Player) {
        CollisionWithEnemy(player, enemy : enemy)
    }
    
    func CollisionWithEnemy(player : Player, enemy : Enemy) {
        enemy.removeFromParent()
        
        player.life--
        
        if(player.life == 0) {
            player.removeFromParent()
            
            var YourScore = NSUserDefaults.standardUserDefaults()
            YourScore.setValue(Score, forKey: "YourScore")
            YourScore.synchronize()
            
            if(Score > Highscore) {
                var HighscoreDefault = NSUserDefaults.standardUserDefaults()
                HighscoreDefault.setValue(Score, forKey: "Highscore")
            }
            
            ScoreLabel.removeFromSuperview()
            LifeLabel.removeFromSuperview()
            self.view?.presentScene(EndScene())
        } else {
            displayCoeurs(player.life, label : LifeLabel)
        }
    }
    
    func displayCoeurs(number : Int, label : UILabel) {
        var attachment = NSTextAttachment()
        attachment.image = UIImage(named: "coeur.png")
        var attachmentString = NSAttributedString(attachment: attachment)
        var myString = NSMutableAttributedString(string: "")
        
        for index in 1...number {
            myString.appendAttributedString(attachmentString)
        }
        
        label.attributedText = myString
    }
    
    func SpawnBullets() {
        
        let bullet = Bullet(image : "bullet.png", zposition : -2, position : CGPointMake(player.position.x, player.position.y), bulletSpeed : 3, scene : self)
        
        self.addChild(bullet)
    }
    
    func SpawnEnnemies() {
        let enemy = Enemy(image : "ennemy.png", enemySpeed : 3, scene : self, life : 3)
        
        self.addChild(enemy)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            
            player.position.x = location.x
        }
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            
            player.position.x = location.x
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
