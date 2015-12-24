//
//  Player.swift
//  Space Defender
//
//  Created by Bew Games on 23/04/2015.
//  Copyright (c) 2015 Bew Games. All rights reserved.
//

import Foundation
import SpriteKit

class Player : SKSpriteNode {
    
    var life : Int
    
    required init?(coder aDecoder: NSCoder) {
        
        self.life = 3
        
        super.init(coder: aDecoder)
    }
    
    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        
        self.life = 3
        
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init(image : String, scene : SKScene, life : Int) {
        let texture = SKTexture(imageNamed: image)
        let color = UIColor()
        
        self.init(texture: texture, color: color, size: texture.size())
        
        self.position = CGPointMake(scene.size.width / 2, scene.size.height / 10)
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.Player
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy
        self.physicsBody?.dynamic = false
        
        self.life = life
    }
}