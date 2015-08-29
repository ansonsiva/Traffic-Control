//
//  Car.swift
//  TrafficControl
//
//  Created by Arturs Derkintis on 8/23/15.
//  Copyright © 2015 Starfly. All rights reserved.
//

import UIKit
import SpriteKit
class Car: SKSpriteNode {
    
    var drives = true
    
    
    var brakes : SKSpriteNode?
    var backWheel : SKSpriteNode?
    var car : SKSpriteNode?
    
    //Contains path on what this car drives
    var path : UIBezierPath?

    var rangeAhead = [CGFloat]()
    
    var turnRects : [CGRect]?
    var gameOverRects : [CGRect]?
    
    var leftIndicator : SKSpriteNode?
    var rightIndicator : SKSpriteNode?
    
    var timer : NSTimer?
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setup()
        
        
    }
    func setup(){
        body()
        brakesLight()
        indicatorLights()
        physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: size.width * 0.9, height: size.height))
        physicsBody?.categoryBitMask = Category.Car
        physicsBody?.contactTestBitMask = Category.Car
        let y = size.height * 0.53
        let maxY = y + (size.height * 1.2)
        for i in y.stride(to: maxY, by: +20){
            rangeAhead.append(i)
            
        }

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: Car Body
    
    func body(){
        car = SKSpriteNode(imageNamed: "car_1")
        car!.size = CGSize(width: size.width, height: size.height)
        car!.position = CGPoint(x: 0, y: 0)
        addChild(car!)
        name = Names.Car
        car!.zPosition = Layer.Car
     
    }
    func brakesLight(){
        brakes = SKSpriteNode(imageNamed: "brakes")
        brakes!.name = Names.Brakes
        brakes!.size = CGSize(width: size.width * 0.8, height: size.width * 0.2)
        brakes!.position = CGPoint(x: 0, y: -(size.height * 0.5))
        brakes!.zPosition = Layer.Brakes
        brakes!.hidden = true
        car!.addChild(brakes!)
    }
    
// MARK: Indicators
    
    func turnOnRightIndicator(state : IndicatorState){
        if state == .right && timer == nil{
            timer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: "switchRightRelay", userInfo: nil, repeats: true)
        }else if state == .left && timer == nil{
            timer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: "switchLeftRelay", userInfo: nil, repeats: true)
        }else if state == .off && timer != nil{
            leftIndicator?.hidden = true
            rightIndicator?.hidden = true
            timer?.invalidate()
            timer = nil
        }
    }
    func switchRightRelay(){
        rightIndicator?.hidden = !rightIndicator!.hidden
    }
    func switchLeftRelay(){
        leftIndicator?.hidden = !leftIndicator!.hidden
    }
    func indicatorLights(){
        leftIndicator = SKSpriteNode(imageNamed: "leftIndi")
        leftIndicator?.size = size
        leftIndicator?.position = CGPoint(x: 0, y: 0)
        leftIndicator?.zPosition = Layer.otherStuff
        leftIndicator?.hidden = true
        car!.addChild(leftIndicator!)
        rightIndicator = SKSpriteNode(imageNamed: "rightIndi")
        rightIndicator?.size = size
        rightIndicator?.position = CGPoint(x: 0, y: 0)
        rightIndicator?.zPosition = Layer.otherStuff
        rightIndicator?.hidden = true
        car!.addChild(rightIndicator!)
    }
    
    
    
// MARK: To Move Or Not To Move
    func drive(){
        if !drives{
            brakes!.hidden = true
            drives = true
            self.runAction(SKAction.speedTo(1.0, duration: 1.0))
        }
        
    }
    func fireBrakes(intense : NSTimeInterval){
        if drives{
            
            brakes?.hidden = false
            let action = SKAction.speedTo(0.0, duration: intense)
            runAction(action)
        }else if !hasActions(){
            //Handbreak
            speed = 0
        }
        drives = false
    }
    
//MARK: Radar
    func radar(){
            ///Indicator lights switch 'sensor'
            turnIndicatorSensor()
            ///'Scans' area ahead
            senseObjectsInFront()
    }
    func senseObjectsInFront(){
        if let par = parent{
        var isSomethingInFront = false
        for distance in rangeAhead{
            //print(distance)
            let point = CGPoint(length: distance, angle: zRotation + CGFloat(M_PI_2))
            let someNodes : [SKNode]? = par.nodesAtPoint(CGPoint(x: position.x + point.x, y: position.y + point.y))
            if let nodes  = someNodes{
                for node in nodes{
                    if node == self{
                        drive()
                        return
                    }
                    //Finds if other cars or invisible barrier is in front
                    if node.name == Names.Car || node.name == Names.Block{
                        //Recheck maybe car in front alrady started to drive
                        if node.speed >= 0.5 && distance > 23 {
                            //if so continue to drive
                            drive()
                            return
                        }
                        //if not break
                        let intense : NSTimeInterval = NSTimeInterval(distance / rangeAhead.last!)
                        //adjust intense for faster or slower breaking
                        fireBrakes(intense * 0.5)
                        
                        isSomethingInFront = true
                        
                        return
                    
                    }
                
                }}
            ///Uncomment this to see visualization of this 'radar'
            /*let sp = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: 2, height: 2))
            sp.zPosition = Layer.otherStuff + 100
            sp.position = CGPoint(x: position.x + point.x, y: position.y + point.y)
            par.addChild(sp)
            sp.runAction(SKAction.sequence([SKAction.waitForDuration(0.3), SKAction.removeFromParent()]))*/
            }
            
        
        if isSomethingInFront == false{
            drive()
            }
        }

    }
    func turnIndicatorSensor(){
        if let tRects = turnRects{
            var isOn = false
            for rect in tRects{
                if CGRectContainsPoint(rect, position) && path!.name == BezierType.Right{
                    turnOnRightIndicator(IndicatorState.right)
                    isOn = true
                }else if CGRectContainsPoint(rect, position) && path!.name == BezierType.Left{
                    turnOnRightIndicator(IndicatorState.left)
                    isOn = true
                }
            }
            if !isOn{
                turnOnRightIndicator(IndicatorState.off)
                
            }
        }
    }
    func trafficJamSensor(completion:(isJam : Bool) -> Void){
        if let trJamRects = gameOverRects{
            for rect in trJamRects{
                
                if CGRectContainsPoint(rect, position) && speed == 0.0{
                    print("Theoreticly game is over")
                    completion(isJam: true)
                }
            }
        }
    }
}
