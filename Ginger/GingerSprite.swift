//
//  Ginger.swift
//  Ballon
//
//  Created by Cheio Wright on 2018/3/3.
//  Copyright © 2018年 Cheio Wright. All rights reserved.
//

import Foundation
import SpriteKit

public class GingerSprite : SKSpriteNode {
    private let movementSpeed : CGFloat = 0.5
    private let walkingActionKey = "action_walking"
    
    private let walkFrames = [
        SKTexture(imageNamed: "ginger"),
        SKTexture(imageNamed: "ginger_walking")
    ]
    
    public static func newInstance() -> GingerSprite {
        let gingerSprite = GingerSprite(imageNamed: "ginger")
        
        gingerSprite.zPosition = 5
        gingerSprite.physicsBody = SKPhysicsBody(circleOfRadius: gingerSprite.size.width / 2)
        gingerSprite.physicsBody?.categoryBitMask = GingerCategory
        gingerSprite.physicsBody?.contactTestBitMask = WorldCategory | FloorCategory
        
        return gingerSprite
    }
    
    public func update(deltaTime : TimeInterval) {
        // ginger's move
        if action(forKey: walkingActionKey) == nil {
            let walkingAction = SKAction.repeatForever(
                SKAction.animate(with: walkFrames,
                                 timePerFrame: 1.0,
                                 resize: false,
                                 restore: true))
            run(walkingAction, withKey:walkingActionKey)
        }
        
        physicsBody?.angularVelocity = 0
    }
}
