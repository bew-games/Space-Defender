//
//  Enemy.swift
//  Space Defender
//
//  Created by Bew Games on 23/04/2015.
//  Copyright (c) 2015 Bew Games. All rights reserved.
//

import Foundation
import SpriteKit

class Enemy : SKSpriteNode {
    
    var life : Int
    
    required init?(coder aDecoder: NSCoder) {
        
        self.life = 3
        
        super.init(coder: aDecoder)
    }
    
    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        
        self.life = 3
        
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init(image : String, enemySpeed : NSTimeInterval, scene : SKScene, life : Int) {
        
        let texture = SKTexture(imageNamed: image)
        let color = UIColor()
        
        self.init(texture: texture, color: color, size: texture.size())
        
        var MinValue = scene.size.width / 7
        var MaxValue = scene.size.width - 90
        var SpawnPoint = UInt32(MaxValue - MinValue)
        
        self.position = CGPointMake(CGFloat(arc4random_uniform(SpawnPoint)), scene.size.height)
        
        let action = SKAction.moveToY(-70, duration: enemySpeed)
        let actionDone = SKAction.removeFromParent()
        
        self.runAction(SKAction.sequence([action, actionDone]))
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: texture.size())
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.Enemy
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Bullet
        self.physicsBody?.dynamic = true
        self.physicsBody?.collisionBitMask = 0
        
        self.life = life
    }
}