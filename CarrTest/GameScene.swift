//
//  GameScene.swift
//  TrafficControl
//
//  Created by Arturs Derkintis on 8/23/15.
//  Copyright (c) 2015 Starfly. All rights reserved.
//

import SpriteKit



class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let trafficLightRed = SKTexture(imageNamed: "traffic_red")
    let trafficLightYellow = SKTexture(imageNamed: "traffic_yellow")
    let trafficLightGreen = SKTexture(imageNamed: "traffic_green")
    
    var cars = [Car]()
    var layerOfCars : SKSpriteNode?
    let beziesr = beziers()
    
    //tapRects
    let hrRect = CGRectMake(513.5, 384.5, 511, 384)
    let hlRect = CGRectMake(0, 0, 511, 384)
    let vlRect = CGRectMake(0.5, 384.5, 511, 384)
    let vrRect = CGRectMake(513.5, 0.5, 511, 384)
    
    
    var hrTrafficLight : SKSpriteNode?
    var hrInvisibleBarrier : SKSpriteNode?
    var hlTrafficLight : SKSpriteNode?
    var hlInvisibleBarrier : SKSpriteNode?
    var vrTrafficLight : SKSpriteNode?
    var vrInvisibleBarrier : SKSpriteNode?
    var vlTrafficLight : SKSpriteNode?
    var vlInvisibleBarrier : SKSpriteNode?
    
    //Inside these Rects indicator lights if needed is turned on
    let hrTurnRect = CGRectMake(527, 386, 300, 74)
    let hlTurnRect = CGRectMake(206, 308, 305, 74)
    let vrTurnRect = CGRectMake(511, 82, 57, 300)
    let vlTurnRect = CGRectMake(457, 384, 57, 300)
    
    //Rects for traffic jam sensoring
    let right = CGRectMake(979, 383, 236, 54)
    let left = CGRectMake(-138, 331, 179, 54)
    let bottom = CGRectMake(512, -121.5, 50, 178)
    let top = CGRectMake(462, 738, 50, 173)
    
    var timer1 : NSTimer?
    var timer2 : NSTimer?
    
    override func didMoveToView(view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "road")
        background.size = frame.size
        background.position = CGPoint(x: CGRectGetMidX(frame), y: CGRectGetMidY(frame))
        addChild(background)
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
        //For lighter tracking, cars has it own subnode.
        layerOfCars = SKSpriteNode()
        layerOfCars?.position = CGPoint(x: 0, y: 0)
        layerOfCars?.anchorPoint = CGPoint(x: 0, y: 0)
        layerOfCars?.size = frame.size
        addChild(layerOfCars!)
        
        //Add traffic lights and barriers
        addHRTrafficLight()
        addHLTrafficLight()
        addVRTrafficLight()
        addVLTrafficLight()
        
        timers(true)
    }
    func timers(on : Bool){
        if on{
        ///Add new car each 2 seconds
        timer1 = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "addCar", userInfo: nil, repeats: true)
        ///Track all cars
        timer2 = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "trackTheCars", userInfo: nil, repeats: true)
        }else{
            timer1?.invalidate()
            timer2?.invalidate()
            timer2 = nil
            timer1 = nil
        }
    }
    func trackTheCars(){
        for car in cars {
            car.radar()
            car.trafficJamSensor({ (isJam) -> Void in
                if isJam {
                    print("too much cars in row")
                    self.gameOver()
                }
            })
        }
    }
    func addCar(){
        let car = Car(texture: nil, color: .clearColor(), size: CGSize(width: 20, height: 44))
        let turnRects = [hrTurnRect, hlTurnRect, vrTurnRect, vlTurnRect]
        let gameOverRects = [right, left, bottom, top]
        car.gameOverRects = gameOverRects
        car.turnRects = turnRects
        car.position = CGPoint(x: -100, y: -100)
        layerOfCars!.addChild(car)
        let bez = beziesr[randomInRange(0, upper: beziesr.count - 1)]
        car.path = bez
        let action = SKAction.followPath(bez.CGPath, asOffset: false, orientToPath: true, speed: 100)
        let remove = SKAction.removeFromParent()
        car.runAction(SKAction.sequence([action, remove])) { () -> Void in
            self.cars.removeAtIndex(self.cars.indexOf(car)!)
        }
        
        
        self.cars.append(car)
    }
  
//Mark: Traffic lights.
    func addHRTrafficLight(){
        ///Actual three color Traffic light node
        hrTrafficLight = SKSpriteNode(texture: trafficLightGreen, color: UIColor.blueColor(), size: CGSize(width: 60 * 0.36, height: 60))
        hrTrafficLight?.position = CGPointMake(610, 460)
        hrTrafficLight?.zPosition = Layer.otherStuff
        hrTrafficLight?.zRotation = 90.degreesToRadians
        addChild(hrTrafficLight!)
        ///Invisible barrier. If its unhidden car 'sees' it and stops right before it.
        hrInvisibleBarrier = SKSpriteNode(color: UIColor.clearColor(), size: CGSize(width: 20, height: 30))
        hrInvisibleBarrier!.position = CGPointMake(575, 410)
        hrInvisibleBarrier!.name = Names.Block
        hrInvisibleBarrier?.zPosition = Layer.otherStuff
        hrInvisibleBarrier?.hidden = true
        hrInvisibleBarrier?.speed = 0
        layerOfCars!.addChild(hrInvisibleBarrier!)
    }
    func addHLTrafficLight(){
        ///Actual three color Traffic light node
        hlTrafficLight = SKSpriteNode(texture: trafficLightGreen, color: UIColor.blueColor(), size: CGSize(width: 60 * 0.36, height: 60))
        hlTrafficLight?.position = CGPointMake(420, 300)
        hlTrafficLight?.zPosition = Layer.otherStuff
        hlTrafficLight?.zRotation = -90.degreesToRadians
        addChild(hlTrafficLight!)
        ///Invisible barrier. If its unhidden car 'sees' it and stops right before it.
        hlInvisibleBarrier = SKSpriteNode(color: UIColor.clearColor(), size: CGSize(width: 20, height: 30))
        hlInvisibleBarrier!.position = CGPointMake(455, 365)
        hlInvisibleBarrier!.name = Names.Block
        hlInvisibleBarrier?.zPosition = Layer.otherStuff
        hlInvisibleBarrier?.hidden = true
        hlInvisibleBarrier?.speed = 0
        layerOfCars!.addChild(hlInvisibleBarrier!)
    }
    func addVRTrafficLight(){
        ///Actual three color Traffic light node
        vrTrafficLight = SKSpriteNode(texture: trafficLightGreen, color: UIColor.blueColor(), size: CGSize(width: 60 * 0.36, height: 60))
        vrTrafficLight?.position = CGPointMake(595, 290)
        vrTrafficLight?.zPosition = Layer.otherStuff
        addChild(vrTrafficLight!)
        ///Invisible barrier. If its unhidden car 'sees' it and stops right before it.
        vrInvisibleBarrier = SKSpriteNode(color: UIColor.clearColor(), size: CGSize(width: 30, height: 20))
        vrInvisibleBarrier!.position = CGPointMake(540, 325)
        vrInvisibleBarrier!.name = Names.Block
        vrInvisibleBarrier?.zPosition = Layer.otherStuff
        vrInvisibleBarrier?.hidden = true
        vrInvisibleBarrier?.speed = 0
        layerOfCars!.addChild(vrInvisibleBarrier!)
    }
    func addVLTrafficLight(){
        ///Actual three color Traffic light node
        vlTrafficLight = SKSpriteNode(texture: trafficLightGreen, color: UIColor.blueColor(), size: CGSize(width: 60 * 0.36, height: 60))
        vlTrafficLight?.position = CGPointMake(440, 480)
        vlTrafficLight?.zPosition = Layer.otherStuff
        vlTrafficLight?.zRotation = 180.degreesToRadians
        addChild(vlTrafficLight!)
        ///Invisible barrier. If its unhidden car 'sees' it and stops right before it.
        vlInvisibleBarrier = SKSpriteNode(color: UIColor.clearColor(), size: CGSize(width: 30, height: 20))
        vlInvisibleBarrier!.position = CGPointMake(490, 450)
        vlInvisibleBarrier!.name = Names.Block
        vlInvisibleBarrier?.zPosition = Layer.otherStuff
        vlInvisibleBarrier?.hidden = true
        vlInvisibleBarrier?.speed = 0
        layerOfCars!.addChild(vlInvisibleBarrier!)
    }

    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       
        for touch in touches {
            let loc = touch.locationInNode(self)
            //Divides sreen in four section for each traffic light
            if CGRectContainsPoint(hrRect, loc){
                if hrInvisibleBarrier!.hidden{
                    switchTrafficLight(hrTrafficLight!, state: .red, barrier : hrInvisibleBarrier!)
                }else{
                    switchTrafficLight(hrTrafficLight!, state: .green, barrier : hrInvisibleBarrier!)
                }
            }else if CGRectContainsPoint(hlRect, loc){
                if hlInvisibleBarrier!.hidden{
                    switchTrafficLight(hlTrafficLight!, state: .red, barrier : hlInvisibleBarrier!)
                }else{
                    switchTrafficLight(hlTrafficLight!, state: .green, barrier : hlInvisibleBarrier!)
                }
            }else if CGRectContainsPoint(vlRect, loc){
                if vlInvisibleBarrier!.hidden{
                    switchTrafficLight(vlTrafficLight!, state: .red, barrier : vlInvisibleBarrier!)
                }else{
                    switchTrafficLight(vlTrafficLight!, state: .green, barrier : vlInvisibleBarrier!)
                }
            }else if CGRectContainsPoint(vrRect, loc){
                if vrInvisibleBarrier!.hidden{
                    switchTrafficLight(vrTrafficLight!, state: .red, barrier : vrInvisibleBarrier!)
                }else{
                    switchTrafficLight(vrTrafficLight!, state: .green, barrier : vrInvisibleBarrier!)
                }
            }
            
        }
    }
    func switchTrafficLight(node : SKSpriteNode, state : TrafficLightState, barrier : SKSpriteNode){
        let actionTurnYellow = SKAction.runBlock({ () -> Void in
            node.texture = self.trafficLightYellow
            
        })
        let waitAction = SKAction.waitForDuration(1)
        let actionTurnRed = SKAction.runBlock { () -> Void in
            node.texture = self.trafficLightRed
            barrier.hidden = false
        }
        let actionTurnGreen = SKAction.runBlock { () -> Void in
            node.texture = self.trafficLightGreen
            barrier.hidden = true
        }
        if state == .red{
            node.runAction(SKAction.sequence([actionTurnYellow, waitAction, actionTurnRed]))
        }else if state == .green{
            node.runAction(SKAction.sequence([actionTurnYellow, waitAction, actionTurnGreen]))
        }
        
    }
    func didBeginContact(contact: SKPhysicsContact) {
        if contact.bodyA.node!.name == Names.Car && contact.bodyB.node!.name == Names.Car{
            let action = SKAction.sequence([SKAction.fadeOutWithDuration(0.1), SKAction.fadeInWithDuration(0.1)])
            let blink = SKAction.repeatAction(action, count: 2)
            contact.bodyB.node?.runAction(blink)
            contact.bodyA.node?.runAction(blink, completion: { () -> Void in
                
                self.gameOver()
            })
            
            print("Car crash")
            
        }
    }
    func gameOver(){
        if !layerOfCars!.paused{
        timers(false)
            
        self.cars.removeAll()
        let gameOver = GameOver()
        gameOver.size = size
        gameOver.zPosition = Layer.gameOver
        gameOver.anchorPoint = CGPoint(x: 0, y: 0)
        gameOver.position = CGPoint(x: 0, y: 0)
        self.layerOfCars?.enumerateChildNodesWithName(Names.Car, usingBlock: { (node : SKNode, obj) -> Void in
                
                node.removeAllActions()
                node.removeFromParent()
        })
      
        self.layerOfCars?.paused = true

        self.addChild(gameOver)
        gameOver.getResponce { (string : NSString?) -> Void in
            self.layerOfCars?.paused = false
            
            gameOver.removeFromParent()
            delay(1, closure: { () -> () in
                
                self.timers(true)
            })
        
            }}
        
        
    }

}
