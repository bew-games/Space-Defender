//
//  Bullet.swift
//  Space Defender
//
//  Created by Bew Games on 23/04/2015.
//  Copyright (c) 2015 Bew Games. All rights reserved.
//

import Foundation
import SpriteKit

class Bullet : SKSpriteNode {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init(image : String, zposition : CGFloat, position : CGPoint, bulletSpeed : NSTimeInterval, scene : SKScene) {
        
        let texture = SKTexture(imageNamed: image)
        let color = UIColor()
        
        self.init(texture: texture, color: color, size: texture.size())
        
        self.zPosition = zposition
        
        self.position = position
        
        let action = SKAction.moveToY(scene.size.height + 40, duration: bulletSpeed)
        let actionDone = SKAction.removeFromParent()
        
        self.runAction(SKAction.sequence([action, actionDone]))
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.Bullet
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy
        self.physicsBody?.dynamic = false
    }
}