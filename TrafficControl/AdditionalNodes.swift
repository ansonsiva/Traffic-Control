//
//  AdditionalNodes.swift
//  TrafficControl
//
//  Created by Arturs Derkintis on 8/28/15.
//  Copyright © 2015 Starfly. All rights reserved.
//

import UIKit
import SpriteKit

class GameOver: SKSpriteNode {
    var comBlock : CompletionBlock?
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
       
        userInteractionEnabled = true
        
    }
    func getResponce(com : CompletionBlock){
        let background = SKSpriteNode(imageNamed: "gameover")
        background.size = size
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.position = CGPoint(x: 0, y: 0)
        background.zPosition = Layer.gameOver
        addChild(background)
        comBlock = com
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches{
            let loc = touch.locationInNode(self)
            print(loc)
            if CGRectContainsPoint(CGRectMake(377, 228, 270, 152), loc){
              comBlock!("Restart")
            
            }
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
