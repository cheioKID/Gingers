//
//  GameScene.swift
//  Ballon
//
//  Created by Cheio Wright on 2018/3/2.
//  Copyright © 2018年 Cheio Wright. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var lastUpdateTime : TimeInterval = 0
    private var gingerSpawnTime : TimeInterval = 0
    private var gingerSpawnRate : TimeInterval = 7
    
    private var groundNode : SKSpriteNode?
    private var storeNode : SKSpriteNode?
    private var ginderNodes = [GingerSprite]()
    private var keyLabel : SKLabelNode?
    private var valueLabel : SKLabelNode?
    //private var spinnyNode : SKShapeNode?
    
    
    
    //let removeGingerAction: SKAction = SKAction.sequence([
    //  SKAction.animate(with: balloonPop, timePerFrame: 1 / 30.0),
    //SKAction.removeFromParent()
    //])
    
    
    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
        
        var worldFrame = frame
        worldFrame.origin.x -= 10
        worldFrame.origin.y -= 10
        worldFrame.size.height += 20
        worldFrame.size.width += 20
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: worldFrame)
        self.physicsBody?.categoryBitMask = WorldCategory
        
        
        self.physicsWorld.contactDelegate = self
        
        spawnGinger()
    }
    
    override func didMove(to view: SKView) {
        /*
         // Get label node from scene and store it for use later
         self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
         if let label = self.label {
         label.alpha = 0.0
         label.run(SKAction.fadeIn(withDuration: 2.0))
         }
         
         // Create shape node to use during mouse interaction
         let w = (self.size.width + self.size.height) * 0.05
         self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
         
         if let spinnyNode = self.spinnyNode {
         spinnyNode.lineWidth = 2.5
         
         spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
         spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
         SKAction.fadeOut(withDuration: 0.5),
         SKAction.removeFromParent()]))
         }*/
    }
    
    /*
     func touchDown(atPoint pos : CGPoint) {
     if let n = self.spinnyNode?.copy() as! SKShapeNode? {
     n.position = pos
     n.strokeColor = SKColor.green
     self.addChild(n)
     }
     }
     
     func touchMoved(toPoint pos : CGPoint) {
     if let n = self.spinnyNode?.copy() as! SKShapeNode? {
     n.position = pos
     n.strokeColor = SKColor.blue
     self.addChild(n)
     }
     }
     
     func touchUp(atPoint pos : CGPoint) {
     if let n = self.spinnyNode?.copy() as! SKShapeNode? {
     n.position = pos
     n.strokeColor = SKColor.red
     self.addChild(n)
     }
     }
     
     override func mouseDown(with event: NSEvent) {
     self.touchDown(atPoint: event.location(in: self))
     }
     
     override func mouseDragged(with event: NSEvent) {
     self.touchMoved(toPoint: event.location(in: self))
     }
     
     override func mouseUp(with event: NSEvent) {
     self.touchUp(atPoint: event.location(in: self))
     }*/
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 0x31:
            if let label = self.keyLabel {
                label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
            }
        case UInt16(10):
            if let label = self.keyLabel {
                label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
            }
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        //ginderNode?.update(deltaTime: dt)
        ginderNodes.map { $0.update(deltaTime: dt) }
        
        // Update the Spawn Timer
        gingerSpawnTime += dt
        
        if gingerSpawnTime > gingerSpawnRate {
            gingerSpawnTime = 0
            spawnGinger()
        }
        
        
        self.lastUpdateTime = currentTime
    }
    
    
    
    
    
    func spawnGinger() {
        
        //  initialized a new cat and set the position to 30 pixels below the umbrella
        let ginderNode = GingerSprite.newInstance()
        var random : CGFloat = CGFloat(arc4random())
        random = random.truncatingRemainder(dividingBy: size.width - 100)
        ginderNode.position = CGPoint(x: random, y: size.height/2 - 100)
        addChild(ginderNode)
        self.ginderNodes.append(ginderNode)
        
        
        
        //resetPoints()
    }
    
    
    func handleGingerCollision(contact: SKPhysicsContact) {
        var otherBody : SKPhysicsBody
        
        if contact.bodyA.categoryBitMask == GingerCategory {
            otherBody = contact.bodyB
        } else {
            otherBody = contact.bodyA
        }
        /*
         switch otherBody.categoryBitMask {
         case StoreCategory:
         //catNode.hitByRain()
         //hudNode.resetPoints()
         case :
         //spawnCat()
         default:
         print("Ginger happen to")
         }*/
    }
    
}
